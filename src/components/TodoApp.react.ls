React = require \react
Footer = require \./Footer.react
Header = require \./Header.react
MainSection = require \./MainSection.react
TodoStore = require \../stores/TodoStore

getTodoState = ->
  allTodos: TodoStore.getAll!
  areAllComplete: TodoStore.areAllComplete!

TodoApp = React.createClass(
  getInitialState: -> getTodoState!
  componentDidMount: -> TodoStore.addChangeListener @._onChange
  componentWillUnmount: -> TodoStore.removeChangeListener @._onChange
  render: ->
    ``<div>
      <Header />
      <MainSection
        allTodos={this.state.allTodos}
        areAllComplete={this.state.areAllComplete}
      />
      <Footer allTodos={this.state.allTodos} />
    </div>``

  _onChange: -> @.setState getTodoState!
)

module.exports = TodoApp

