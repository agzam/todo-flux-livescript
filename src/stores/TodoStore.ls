AppDispatcher = require \../dispatcher/AppDispatcher
TodoConstants = require \../constants/TodoConstants
assign = require \object-assign

EventEmitter = (require \events ).EventEmitter
CHANGE_EVENT = \change
_todos = {}

create = (text) ->
  id = ((+new Date) + Math.floor Math.random! * 999999).toString 36
  _todos[id] =
    id: id
    complete: false
    text: text


update = (id, updates) -> _todos[id] = assign {}, _todos[id], updates

updateAll = (updates) ->
  for id of _todos
    update id, updates

destroy = (id) -> delete! _todos[id]

destroyCompleted = ->
  for id of _todos
    destroy id if _todos[id].complete

TodoStore = assign {}, EventEmitter.prototype, {
  areAllComplete: ->
    for id of _todos
      return false if not _todos[id].complete
    true
  getAll: -> _todos
  emitChange: -> @emit CHANGE_EVENT
  addChangeListener: (callback) -> @on CHANGE_EVENT, callback
  removeChangeListener: (callback) -> @removeListener CHANGE_EVENT, callback
}

AppDispatcher.register (action)->
  text = ''
  switch action.actionType
    case TodoConstants.TODO_CREATE
      text = action.text.trim!
      create text   if text isnt ''
      TodoStore.emitChange!
    case TodoConstants.TODO_TOGGLE_COMPLETE_ALL
      if TodoStore.areAllComplete! then updateAll {complete: false} else updateAll {complete: true}
      TodoStore.emitChange!
    case TodoConstants.TODO_UNDO_COMPLETE
      update action.id, {complete: false}
      TodoStore.emitChange!
    case TodoConstants.TODO_COMPLETE
      update action.id, {complete: true}
      TodoStore.emitChange!
    case TodoConstants.TODO_UPDATE_TEXT
      text = action.text.trim!
      update action.id, {text: text} if text isnt ''
      TodoStore.emitChange!
    case TodoConstants.TODO_DESTROY
      destroy action.id
      TodoStore.emitChange!
    case TodoConstants.TODO_DESTROY_COMPLETED
      destroyCompleted!
      TodoStore.emitChange!

module.exports = TodoStore
