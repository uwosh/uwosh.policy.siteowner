## Controller Validator "removeGroupMembersValidator"
##bind container=container
##bind context=context
##bind namespace=
##bind script=script
##bind state=state
##bind subpath=traverse_subpath
##parameters=
##title=

#users = context.acl_users
#pgm = users.source_groups
pg = context.portal_groups
pm = context.portal_membership

# validate your variables here
groupId = context.REQUEST.get('groupId', None)
if not groupId:
   state.setError('groupId', 'Please select a group')
else:
  #groups = pgm.getGroupIds()
  groups = pg.getGroupIds()
  if groupId not in groups:
    state.setError('groupId', 'The group ID "%s" does not exist' % groupId)

userIds = context.REQUEST.get('userIds', None)
userIds = [u.strip() for u in userIds.split("\n")]

if not len(userIds) or not userIds:
   state.setError('userIds', 'Please enter one or more user IDs')
else:
  #who = [w[0] for w in pgm.listAssignedPrincipals(groupId)]
  who = pg.getGroupMembers(groupId)
  for userId in userIds:
    if userId and userId not in who:
      state.setError('userIds', 'The user ID "%s" is not in the group ID "%s".' % (userId, groupId))

if state.getErrors():
   # An error has occurred.  Set the status to 'failure' 
   # (the default initial status is 'success')
   state.setStatus('failure')

# No errors.  Always make sure to return the ControllerState object
return state
