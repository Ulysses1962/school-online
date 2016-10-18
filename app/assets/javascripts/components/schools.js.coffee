@Schools = React.createClass
  getInitialState: ->
    schools: @props.data
  getDefaultProps: ->
    schools: []  
  render: ->
    React.DOM.table
      className: 'table'
      React.DOM.thead null,
        React.DOM.tr null,
          React.DOM.th null, 'Код'
          React.DOM.th null, 'Назва навчального закладу'
          React.DOM.th null, '*'
      React.DOM.tbody null,
        for school in @state.schools  
          React.createElement School, key: school.id, school: school        
