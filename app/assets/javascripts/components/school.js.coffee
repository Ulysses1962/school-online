@School = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.school.school_code
      React.DOM.td null, @props.school.school_name