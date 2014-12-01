from Products.CMFCore.utils import getToolByName
import logging

logger = logging.getLogger("uwosh.policy.siteowner")

def install(context):
    if not context.readDataFile('uwosh.policy.siteowner.txt'):
        return 
    pg = getToolByName(context.getSite(), 'portal_groups', None)
    if not pg:
        logger.error("unable to locate portal_groups tool")
        return
    pg.addGroup(id='Site Owners', roles=['SiteOwner', ])
    if 'Site Owners' in pg.getGroupIds():
        logger.info("created Site Owners group OK")
    else:
        logger.error("unable to create Site Owners group")
