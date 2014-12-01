## Controller Python Script "addGroupMembersDoer"
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
userIds = context.REQUEST.get('userIds')
userIds = [u.strip() for u in userIds.split("\n")]

users = context.acl_users
pgm = users.source_groups
pm = context.portal_membership
me = pm.getAuthenticatedMember()

for userId in userIds:
    if userId and pm.getMemberInfo(userId):
        if pgm.addPrincipalToGroup(userId, groupId):
            logger.info('%s added user ID "%s" to group ID "%s" ok' % (me, userId, groupId))
        else:
            logger.warn('%s unable to add user ID "%s" to group ID "%s"' % (me, userId, groupId))
    else:
        logger.warn('user ID "%s" does not exist' % (userId))

# (Optional) set the default next action (this can be overridden
# in the script's actions tab in the ZMI).
state.setNextAction('traverse_to:string:addGroupMembers')

# Always make sure to return the ControllerState object
return state
