-- -----------------------------------------------------------------------
-- lsyncd.conf.lua for distributing webserver domain files across cloud nodes.
--
-- NOTE This assumes a http://www.tuxlite.com webserver installation.
--
-- Author: Danny Sheehan http://www.setuptips.com
--
-- -----------------------------------------------------------------------

settings {
  logfile = "/var/log/lsyncd.log",
  statusFile = "/var/log/lsyncd-status.log",
  statusInterval = 10,
}

-- -----------------------------------------------------------------------

-- Sync from this host to 'dest_host' over ssh via user 'dest-user'.
local function synccloud(dest_host, dest_user, dest_port)

log('Normal', 'syncloud(', dest_host, ', ', dest_user, ', ', dest_port, ')\n')

  sync {
    default.rsyncssh,
    delay = 3,
    source = '/home/'..dest_user..'/domains',
    targetdir = '/home/'..dest_user..'/domains',
    excludeFrom = "/etc/lsyncd/lsyncd.exclude",
    host  = ''..dest_user..'@'..dest_host..'',
    
    rsync = {
      archive = true,
      compress = true,
      perms = true,
      owner = true
    },
   
    ssh={
     port = dest_port,
    }
    
  }

end


-- ------------------------------------------------------------------
-- Add you cloud node syncronizations here.
-- In this example lsyncd is setup on ds1.ftmon.org
-- and rsyncs website changes to nodes ds2 and ds3.

-- 1st node
-- synccloud("ds2.ftmon.org", "blogswww", 2222)
-- synccloud("ds2.ftmon.org", "forumswww", 2222)
-- synccloud("ds2.ftmon.org", "drupalwww", 2222)

-- 2nd node
-- synccloud("ds3.ftmon.org", "blogswww", 2222)
-- synccloud("ds3.ftmon.org", "forumswww", 2222)
-- synccloud("ds3.ftmon.org", "drupalwww", 2222)
