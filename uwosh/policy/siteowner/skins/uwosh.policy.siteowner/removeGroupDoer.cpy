## Controller Python Script "removeGroupDoer"
##bind container=container
##bind context=context
##bind namespace=
##bind script=script
##bind subpath=traverse_subpath
##parameters=
##title=

import logging
logger=logging.getLogger(script.id)

groupId = context.REQUEST.get('groupId')

pg = context.portal_groups
pm = context.portal_membership
me = pm.getAuthenticatedMember()

if pg.removeGroup(groupId):
    logger.info('%s removed group ID "%s" ok' % (me, groupId))

# (Optional) set the default next action (this can be overridden
# in the script's actions tab in the ZMI).
state.setNextAction('traverse_to:string:removeGroup')

# Always make sure to return the ControllerState object
return state
