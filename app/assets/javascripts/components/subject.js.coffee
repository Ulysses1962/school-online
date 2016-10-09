@Subject = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit  
  handleEdit: (e) ->
    e.preventDefault()
    data = 
      name: ReactDOM.findDOMNode(@refs.name).value
      level: ReactDOM.findDOMNode(@refs.level).value
    $.ajax
      method: 'PUT'
      url: "/admin/subjects/#{@props.subject.id}"
      dataType: 'JSON'
      data:
        subject: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.subject, data      
  recordRaw: ->
    React.DOM.tr null,
      React.DOM.td null, @props.subject.name
      React.DOM.td null, @props.subject.level
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-primary'
          onClick: @handleToggle
          'Edit'
  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.subject.name
          ref: 'name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.subject.level
          ref: 'level'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRaw()                  

