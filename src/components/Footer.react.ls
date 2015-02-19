React = require \react
TodoActions = require \../actions/TodoActions

ReactPropTypes = React.PropTypes

Footer = React.createClass (
  propTypes:  allTodos: ReactPropTypes.object.isRequired
  render: ->
    allTodos = @.props.allTodos
    total = Object.keys(allTodos).length
    return null if total is 0
    completed = 0
    for key of allTodos
      completed++ if allTodos[key].complete

    itemsLeft = total - completed
    itemsLeftPhrase = if itemsLeft is 1 then ' item ' else ' items '
    itemsLeftPhrase += 'left'

    # Undefined and thus not rendered if no completed items are left.
    clearCompletedButton
    if completed
      clearCompletedButton = ``
        <button
          id="clear-completed"
          onClick={this._onClearCompletedClick}>
          Clear completed ({completed})
        </button>``

    return ``<footer id="footer">
               <span id="todo-count">
                 <strong>
                   {itemsLeft}
                 </strong>
                 {itemsLeftPhrase}
               </span>
               {clearCompletedButton}
            </footer>``

  _onClearCompletedClick: -> TodoActions.destroyCompleted!
)
module.exports = Footer
