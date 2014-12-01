## Controller Validator "removeGroupValidator"
##bind container=container
##bind context=context
##bind namespace=
##bind script=script
##bind state=state
##bind subpath=traverse_subpath
##parameters=
##title=
##

groupId = context.REQUEST.get('groupId', None)
if not groupId:
   state.setError('groupId', 'Please enter a group ID')
else:
    pg = context.portal_groups
    if groupId not in pg.getGroupIds():
       state.setError('groupId', 'The group ID "%s" does not exist.' % groupId)
    else:
        if len(pg.getGroupMembers(groupId)):
           state.setError('groupId', 'The group ID "%s" is not empty.' % groupId)

if state.getErrors():
   # An error has occurred.  Set the status to 'failure' 
   # (the default initial status is 'success')
   state.setStatus('failure')

# No errors.  Always make sure to return the ControllerState object
return state
