
CLAUDE.md
=========

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

What this is
------------

A SaltStack formula that installs, configures, and manages the `Cobbler <https://cobbler.github.io/>`_ autoinstallation
server. It follows the `\ ``saltstack-formulas`` <https://github.com/saltstack-formulas>`_ conventions (this repo is built
from ``template-formula``\ ), including the ``map.jinja`` parameter-resolution pattern and the TOFS (Template Override and
Files Switch) pattern for file lookup.

Repository layout
-----------------


* ``cobbler/`` — the formula itself (top-level dir name must match ``top_level_dir`` in ``FORMULA``\ )

  * ``init.sls`` / ``clean.sls`` — meta-states that include ``package`` → ``config`` → ``service`` (and the reverse for clean)
  * ``package/``\ , ``config/``\ , ``service/`` — one subdir per concern, each with its own ``init.sls`` and usually a ``clean.sls``
  * ``map.jinja``\ , ``libmapstack.jinja``\ , ``libmatchers.jinja``\ , ``libsaltcli.jinja`` — parameter-resolution machinery, copied
    verbatim from ``template-formula``\ ; do not hand-edit the resolution logic without a strong reason
  * ``libtofs.jinja`` — defines the ``files_switch`` macro used by state files to pick config templates
  * ``parameters/`` — YAML defaults, layered by ``os``\ , ``os_family``\ , ``osarch``\ , ``osfinger`` (see ``defaults.yaml`` for the
    full set of formula options and their defaults)
  * ``files/default/`` — Jinja config templates (e.g. ``settings.yaml.jinja``\ , ``modules.conf.jinja``\ , ``mongodb.conf.jinja``\ ),
    versioned per Cobbler release (subdirectories like ``3.3.4/``\ )

* ``pillar.example`` — canonical example of all pillar options a formula user can set, including ``tofs`` overrides
* ``test/salt/pillar/`` — pillar fixtures used by kitchen-salt during CI convergence
* ``test/integration/default/controls/`` — InSpec tests (\ ``config.rb``\ , ``packages.rb``\ , ``services.rb``\ , ``_mapdata.rb``\ )
* ``test/integration/default/files/_mapdata/`` — per-OS expected ``mapdata`` fixtures used by ``_mapdata.rb`` to assert the
  map/parameter resolution produced the correct merged values for each platform
* ``docs/map.jinja.rst``\ , ``docs/TOFS_pattern.rst`` — the canonical explanations of the two core patterns above; read
  these before changing ``map.jinja``\ , ``libmapstack.jinja``\ , or ``libtofs.jinja``
* ``kitchen.yml`` — defines the test-kitchen platforms (OS/Salt version combinations) tested in CI

How configuration resolution works
----------------------------------

``cobbler/map.jinja`` builds the ``mapdata`` variable (imported into state files as e.g. ``cobbler``\ ) by layering YAML
sources in this order (later overrides earlier):


#. ``parameters/defaults.yaml``
#. ``parameters/osarch/<osarch>.yaml``
#. ``parameters/os_family/<os_family>.yaml``
#. ``parameters/os/<os>.yaml``
#. ``parameters/osfinger/<osfinger>.yaml``
#. ``salt['config.get']('cobbler:lookup')``
#. ``salt['config.get']('cobbler')`` (i.e. pillar/config data)
#. ``parameters/id/<minion_id>.yaml`` (if present)

Each YAML source may also have a ``.yaml.jinja`` counterpart that is rendered first. State files must never call
``salt['pillar.get']``\ /\ ``salt['grains.get']``\ /\ ``salt['config.get']`` directly — all values should flow through ``mapdata``.
See ``docs/map.jinja.rst`` for the full source-syntax reference (\ ``Y``\ /\ ``C``\ /\ ``G``\ /\ ``I`` prefixes, custom ``map_jinja.yaml``
sources, etc.).

File template selection uses the TOFS ``files_switch`` macro (\ ``libtofs.jinja``\ ): it searches
``salt://cobbler/files/<switch-value>/...`` across a configurable list of grains (\ ``id``\ , ``roles``\ , ``osfinger``\ , ``os``\ ,
``os_family``\ , ``default``\ , ...), configurable per-formula via the ``cobbler:tofs`` pillar key. See ``docs/TOFS_pattern.rst``.

Common commands
---------------

Testing (kitchen-salt + InSpec, requires Ruby + Docker)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   bundle install                       # first time only
   bin/kitchen test [platform]          # destroy + converge + verify + destroy
   bin/kitchen converge [platform]      # create instance and run the `cobbler` state
   bin/kitchen verify [platform]        # run InSpec tests against a converged instance
   bin/kitchen login [platform]         # SSH into the test instance
   bin/kitchen destroy [platform]       # tear down the test instance
   bin/kitchen list                     # list available platform suite names

``[platform]`` names come from ``kitchen.yml`` (e.g. ``default-ubuntu-2404-master-py3``\ ). The only suite is ``default``\ ,
combined with each OS/Salt-version entry under ``platforms``.

Linting
^^^^^^^

.. code-block:: bash

   bin/install-hooks                    # one-time: installs pre-commit + commit-msg git hooks
   pre-commit run --all-files           # run all configured linters (yamllint, salt-lint, rstcheck, rst-lint, rubocop, shellcheck, commitlint)
   bundle exec rubocop                  # Ruby lint only (test-kitchen/InSpec helper code)

Individual hooks can be targeted with ``pre-commit run <hook-id> --all-files`` (hook ids: ``commitlint``\ , ``rubocop``\ ,
``shellcheck``\ , ``yamllint``\ , ``salt-lint``\ , ``rstcheck``\ , ``rst-lint``\ ).

Commit messages
---------------

Commit message format is enforced by ``commitlint`` (Conventional Commits, see ``commitlint.config.js``\ ) both via
pre-commit hook and CI, and drives semantic-release versioning (\ ``release.config.js``\ , ``release-rules.js``\ ). Non-conforming
commit messages will fail CI.

Adding support for a new OS or Cobbler version
----------------------------------------------


* New OS defaults go under ``cobbler/parameters/{os,os_family,osarch,osfinger}/``\ ; only include keys that differ from
  ``defaults.yaml`` (+ any already-applied layer).
* New Cobbler versions need a corresponding ``cobbler/files/default/<version>/`` directory with the Jinja templates
  referenced in ``cobbler/config/file.sls`` (\ ``settings.yaml.jinja``\ , ``modules.conf.jinja``\ , ``mongodb.conf.jinja``\ ).
* Community repository OS/version compatibility is hard-coded in ``cobbler/package/repository.sls`` (\ ``repo_version``\ ,
  ``repo_os_name`` maps) — update these when adding a new Cobbler community-repo release or OS.
* Add matching InSpec fixtures under ``test/integration/default/files/_mapdata/<platform>.yaml`` and pillar/kitchen
  platform entries if the new OS should be covered by CI.
