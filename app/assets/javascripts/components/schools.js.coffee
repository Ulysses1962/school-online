@Schools = React.createClass
  getInitialState: ->
    schools: @props.data
  getDefaultProps: ->
    schools: []  
  render: ->
    React.DOM.table
      className: 'table table-striped'
      React.DOM.thead
        React.DOM.tr 
          React.DOM.th
            className: 'col-md-2'
            'Код'
          React.DOM.th
            className: 'col-md-6'
            'Назва навчального закладу'
          React.DOM.th
            classNmae: 'col-md-4'
            '*'
      React.DOM.tbody
        for school in @state.Schools  
          React.createElement School, key: school.id, school: school        
