React = require \react
TodoActions = require \../actions/TodoActions
TodoItem = require \./TodoItem.react
ReactPropTypes = React.PropTypes

MainSection = React.createClass(
  propTypes:
    allTodos: ReactPropTypes.object.isRequired
    areAllComplete: ReactPropTypes.bool.isRequired

  render: ->
    # This section should be hidden by default
    # and shown when there are todos.
    return null  if Object.keys(@.props.allTodos).length < 1

    allTodos = @.props.allTodos
    todos = []

    for key of allTodos
      todos.push ``<TodoItem key={key} todo={allTodos[key]} />``

    return ``<section id="main">
               <input
                  id="toggle-all"
                  type="checkbox"
                  onChange={this._onToggleCompleteAll}
                  checked={this.props.areAllComplete ? 'checked' : ''}
               />
               <label htmlFor="toggle-all">Mark all as complete</label>
               <ul id="todo-list">{todos}</ul>
             </section>``

  /**
   * Event handler to mark all TODOs as complete
   */
  _onToggleCompleteAll: -> TodoActions.toggleCompleteAll!
)
module.exports = MainSection

