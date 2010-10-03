# DesignAdmin

A design business admin system

- Version: 0.2
- Date: 2010-10-02
- Download: <http://symphony-cms.com/download/ensembles/view/47102/>
- Github Repository: <http://github.com/builders/designadmin/>
- Forum Discussion: <http://symphony-cms.com/discuss/thread/47103/>

## Release Notes

#### [Version 0.2](http://github.com/builders/designadmin/commits/0.2)

- Date: 2 Oct 2010
- Update to Symphony 2.1.1
- Update Export Forum Ensemble extension

#### [Version 0.1](http://github.com/builders/designadmin/commits/0.1)

- Date: 6 July 2010
- Initial Release
- Symphony 2.0.8RC3

### Description

When I was freelancing under the name [bauhouse](http://bauhouse.ca/), I had to wear a lot of hats. Finding the right tools to run my site, administrate my business and facilitate communication with my clients was a challenge.

While in search of tools that could simplify the administration of my design business, I found that software would force me to work a certain way, depending on what I was working on. Duplication of data entry was the biggest frustration. For a freelance business, it would be ideal to enter data once and be able to view information in many forms without having to switch from one application to another.

I found that this was not easily feasible … until Symphony came along. Since the introduction of sections and custom fields that could be configured according to the needs of the Symphony developer, specifically section links (a feature that I requested), I have been thinking about how this feature might be used to build a project management system.

I am in the process of building a project management system that uses Symphony to keep track of clients, projects and timesheets. Eventually, I want it to do everything, because I am tired of switching between several applications (desktop and web) that don’t work together and force me to duplicate my efforts. This is a long-term project, but I am trying to solve problems I have had with running my business since I started it 16 years ago. I have never found a system that does what I need, so I am building it myself - necessity being the mother of invention.

It will be a design business administration system built on the Symphony framework that will track clients, projects, timesheets, estimates, invoices, bookkeeping and accounting reports, tax filing, as well as serve as a client login area to allow basecamp style project management, except with the ability to display work in progress according to project phase, with individual entries for each concept, with commenting enabled for each entry. Once an identity system has been developed, it can then be rolled out within the same system, to display an online corporate identity standards manual and provide a means of distributing logo file formats available for download.



# Symphony 2 #

- Version: 2.1.1
- Date: 18th Aug 2010
- Release Notes: <http://symphony-cms.com/download/releases/version/2.1.1/>
- Github Repository: <http://github.com/symphonycms/symphony-2/tree/2.1.1>


## Synopsis

Symphony is a `PHP` & `MySQL` based CMS that utilises `XML` and `XSLT` as 
its core technologies. This repository represents version "2.1.1" and is 
considered stable.

Visit the forum at <http://symphony-cms.com/discuss/>

### Symphony Server Requirements

- PHP 5.2 or above
- PHP's LibXML module, with the XSLT extension enabled (--with-xsl)
- MySQL 4.1 or above
- An Apache or Litespeed webserver
- Apache's mod_rewrite module or equivalent

## Updating From an Older Version

### Important Information

As of version `2.1`, Symphony stores passwords using the more secure 
[SHA1](http://php.net/sha1) algorithm (previous versions used MD5). 
When updating to 2.1, the primary user's login password will be reset
(the new password will be displayed by the updater—please note it).
 **Please also note that all other users' passwords will no longer be valid
and will require a manual reset through Symphony's forgotten password feature.** 
Alternatively, as an administrator, you can also change your users' 
passwords on their behalf.

Version `2.0.5` introduced multiple includable elements, in the Data Source 
Editor, for a single field. After updating from `2.0.5` or lower, the DS 
editor will seem to "forget" about any `Textarea` fields selected when you 
are editing existing Data Sources. After updating, you must ensure you 
re-select them before saving. Note, this will only effect Data Sources that 
you edit and were created prior to `2.0.5`. Until that point, the field will 
still be included in any front-end XML

### Via Git

### Important Information

As of version 2.1, we are now using [GitHub's organisations feature](http://github.com/blog/674-introducing-organizations). As a result, all submodules—as well as the main Symphony 2 repo—are forks owned by the
[Symphony CMS organisation](http://github.com/symphonycms/). To fully update your 
git based installation, please edit your `.git/config` and the `.git/config`
of all core extensions (`debugdevkit`, `profiledevkit`, `markdown`, `maintenance_mode`, 
`selectbox_link_field`, `jit_image_manipulation` and `export_ensemble`) and change
the URL of the remote repo from `symphony` or `pointybeard` to be `symphonycms`.

For example:

	[remote "origin"]
		fetch = +refs/heads/*:refs/remotes/origin/*
		url = git://github.com/pointybeard/markdown.git

Change `git://github.com/pointybeard/markdown.git` to `git://github.com/symphonycms/markdown.git`

1. Pull from the master branch at `git://github.com/symphonycms/symphony-2.git`

2. Use the following command to get Extensions up to date:

	git submodule init
	git submodule update

3. If updating from a version older than `2.0.5`, enable [Debug DevKit](http://github.com/symphonycms/debugdevkit/tree/master) and [Profile DevKit](http://github.com/symphonycms/profiledevkit/tree/master) extensions.

3. Go to `http://yoursite.com/update.php` to complete the update process.

4. You and your website are now in the future. Buy yourself a silver jumpsuit.

### Via the old fashioned way

Follow the instructions below if you are updating from Symphony version 2.0 (not from Git)

**Note:** As of 2.0.6, there is no longer a need to backup `/symphony/.htaccess`.

1. Upload `/symphony`, `index.php` & `update.php`, replacing what is already on your server.

2. If you are updating from a version older than 2.0.5, download and install the Debug DevKit and Profile DevKit:

	- [Debug DevKit](http://github.com/symphonycms/debugdevkit/tree/master)
	- [Profile DevKit](http://github.com/symphonycms/profiledevkit/tree/master)

3. Go to `http://yoursite.com/update.php` to complete the update process.

4. Call a friend and brag that your copy of Symphony is newer than theirs.


## Installing Symphony

### Via Git

1. Clone the git repository to the location you desire using:

		git clone git://github.com/symphonycms/symphony-2.git
		
	Should you wish to make contributions back to the project, fork the master tree rather than cloning, and issue pull requests via github.

	The following repositories are included as submodules:

	- [Markdown](http://github.com/symphonycms/markdown)
	- [Maintenance Mode](http://github.com/symphonycms/maintenance_mode)
	- [Select Box Link Field](http://github.com/symphonycms/selectbox_link_field)
	- [JIT Image Manipulation](http://github.com/symphonycms/jit_image_manipulation)
	- [Export Ensemble](http://github.com/symphonycms/export_ensemble)
	- [Debug DevKit](http://github.com/symphonycms/debugdevkit/tree/master)
	- [Profile DevKit](http://github.com/symphonycms/profiledevkit/tree/master)

3. Run the following command to ensure the submodules are cloned:

		git submodule update --init

4. _(Optional)_ If you would like the [default ensemble](http://github.com/symphonycms/workspace/tree) installed as well, 
you will need to use the following command from within the Symphony 2 folder you just created:

		git clone git://github.com/symphonycms/workspace.git
		
5. Point your web browser at <http://yourwebsite.com/install.php> and provide
details for establishing a database connection and about your server environment.

6. Chuckle villainously and tap your fingertips together (or pet a cat) as your installation completes.


### Via the old fashioned way

**Note: You can leave `/workspace` out if you do not want the default theme.**

1. This step assumes you downloaded a zip archive from the [Symphony website](http://symphony-cms.com). 
Upload the following files and directories to the root directory of your website:

	- index.php
	- install.php
	- install.sql
	- /symphony
	- /workspace
	- /extensions

2. Point your web browser at <http://yourwebsite.com/install.php> and provide
details for establishing a database connection and about your server environment.

3. Pose like you're being filmed for a dramatic close-up while your installation completes.


## Security

**Secure Production Sites: Change permissions and remove installer files.**

1. For a smooth install process, change permissions for the `root` and `workspace` directories.

	cd /your/site/root
	chmod -R 777 workspace

2. Once successfully installed, change permissions as per your server preferences, E.G.

	chmod 755 .

3. Remove installer files (unless you're fine with revealing all your trade secrets):

	rm install.php install.sql workspace/install.sql update.php

4. Dance like it's 1894!
