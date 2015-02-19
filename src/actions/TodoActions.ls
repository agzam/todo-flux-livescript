AppDispatcher = require \../dispatcher/AppDispatcher
TodoConstants = require \../constants/TodoConstants

TodoActions =
  create: (text) ->
    AppDispatcher.dispatch(
      actionType: TodoConstants.TODO_CREATE
      text: text
    )
  updateText: (id, text) ->
    AppDispatcher.dispatch(
      actionType: TodoConstants.TODO_UPDATE_TEXT
      id: id
      text: text
    )
  toggleComplete: (todo) ->
    id = todo.id
    if todo.complete
      AppDispatcher.dispatch(
        actionType: TodoConstants.TODO_UNDO_COMPLETE
        id: id
      )
    else
      AppDispatcher.dispatch(
        actionType: TodoConstants.TODO_COMPLETE
        id: id
      )
  toggleCompleteAll: -> AppDispatcher.dispatch actionType: TodoConstants.TODO_TOGGLE_COMPLETE_ALL
  destroy: (id) ->
    AppDispatcher.dispatch(
      actionType: TodoConstants.TODO_DESTROY
      id: id
    )
  destroyCompleted: -> AppDispatcher.dispatch actionType: TodoConstants.TODO_DESTROY_COMPLETED

module.exports = TodoActions