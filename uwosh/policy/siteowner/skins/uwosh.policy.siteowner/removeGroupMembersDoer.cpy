## Controller Python Script "removeGroupMembersDoer"
##bind container=container
##bind context=context
##bind namespace=
##bind script=script
##bind subpath=traverse_subpath
##parameters=
##title=

import logging
logger=logging.getLogger(script.id)

groupId = context.REQUEST.get('groupId') #or "Reviewers"
userIds = context.REQUEST.get('userIds') #or "loker \nnguyen  \n"
userIds = [u.strip() for u in userIds.split("\n")]

logger.info("groupId = '%s'" % groupId)
logger.info("userIds = '%s', length '%s'" % (userIds, len(userIds)))

# do something with the values here
#users = context.acl_users
#pgm = users.source_groups
pg = context.portal_groups
pm = context.portal_membership
me = pm.getAuthenticatedMember()

#who = [u[0] for u in pgm.listAssignedPrincipals(groupId)]
who = pg.getGroupMembers(groupId)
for u in userIds:
    if u in who:
        logger.info('%s about to remove userId %s' % (me, u))
        pg.removePrincipalFromGroup(u, groupId)
        #who2 = [u[0] for u in pgm.listAssignedPrincipals(groupId)]
        who2 = pg.getGroupMembers(groupId)
        if u in who2:
            logger.info('ERROR - %s failed to remove user "%s" from groupId "%s"' % (me, u, groupId))
        else:
            logger.info('OK - %s removed user "%s" from groupId "%s"' % (me, u, groupId))

# (Optional) set the default next action (this can be overridden
# in the script's actions tab in the ZMI).
state.setNextAction('traverse_to:string:removeGroupMembers')

# Always make sure to return the ControllerState object
return state
