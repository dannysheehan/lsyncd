> **Archived.** This is a 2013 lsyncd config, not the [upstream lsyncd](https://github.com/lsyncd/lsyncd) project. It pushed tuxlite vhost trees from a master web node (`ds1.ftmon.org`) to two slaves over rsync+ssh.
>
> That is not a good 2026 setup:
> - This repo is site glue for one LAMP cluster. Copy [lsyncd](https://github.com/lsyncd/lsyncd) itself if you want the daemon. Upstream has been [up for adoption](https://github.com/lsyncd/lsyncd) since late 2024.
> - Live-mirroring web roots with inotify+rsync is still a niche, but a shared filesystem, object storage, or deploying the same tree to every node is the usual answer now.
> - Pairing this with round-robin DNS (see [djbdns-tinydns](https://github.com/dannysheehan/djbdns-tinydns)) made a small Apache cluster look like one site. A real load balancer does that job.
>
> Left here as a historical example of master-to-slave lsyncd for tuxlite `/home/<user>/domains`.

# lsyncd (ftmon config)

Lua config to keep two web servers in sync from a master. Assumes [tuxlite](https://github.com/minsunw/tuxlite) and [lsyncd](https://github.com/lsyncd/lsyncd) `default.rsyncssh`.

`lsyncd.conf.lua` defines `synccloud(host, user, port)`: watch `/home/<user>/domains` and rsync it to the same path on the peer over ssh (port 2222 in the example). `lsyncd.exclude` skips cache and log dirs so those stay local. The `synccloud(...)` calls are commented; uncomment one pair per vhost user (`blogswww`, `forumswww`, `drupalwww`) per slave (`ds2`, `ds3`).

Last real change June 2013.
