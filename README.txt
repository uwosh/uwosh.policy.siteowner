Introduction
============

Sometimes you want to give a Plone site owner complete editorial
control over the content and portlets of the site, but prevent the
site owner from damaging the site unwittingly.

This product provides a new SiteOwner role that is like Manager role,
except a bit less dangerous.  Without full Manager role, the site
owner is unable to change the configuration of the site.

This product creates a Site Owners group to which the SiteOwner role
is assigned.

Also included are four forms (addGroup, removeGroup, addGroupMembers,
removeGroupMembers) which the SiteOwner role can use, and one
portal_action "Manage groups".

The use case for this product is University of Wisconsin Oshkosh's
central hosting for 200+ Plone sites.  When we create a new Plone
site, we no longer automatically add the site owner to the
Administrators group but to the Site Owners group instead.
