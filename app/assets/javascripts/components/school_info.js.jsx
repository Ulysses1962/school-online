class SchoolInfo extends React.Component {
  constructor(props) {
    super(props);

    this.handleToggleMode = this.handleToggleMode.bind(this);
  };

  handleToggleMode(event) {
    event.preventDefault();
    this.props.handleEdit(this.props.school);
  }

  render() {
    return (
      <tr>
        <td>{ this.props.school.school_code }</td>
        <td>{ this.props.school.school_name }</td>
        <td></td>
        <td>
          <button className="btn btn-danger" onClick={this.handleToggleMode}>
            <i className="glyphicon glyphicon-pencil"></i>   Редагувати
          </button>  
        </td>
        <td></td>
      </tr>
    ); 
  };
}