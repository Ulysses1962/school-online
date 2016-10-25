class SchoolForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      school_code: this.props.school.school_code,
      school_name: this.props.school.school_name,
      school_email: this.props.school.school_email,
      school_address_string: this.props.school.school_address_string,
      school_phone: this.props.school.school_phone
    };   

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleCancel = this.handleCancel.bind(this); 
  };

  handleChange(event) {
    event.preventDefault();
    this.setState({
      [event.target.name]: event.target.value 
    });
  }

  handleSubmit(event) {
    event.preventDefault();
    URI = '/admin/schools/' + this.props.school.id;

    $.ajax({
      url: URI,
      method: 'PUT',
      processData: false,
      contentType: 'application/json',
      data: JSON.stringify({
        school: {
          id: this.props.school.id,
          school_code: this.state.school_code,
          school_name: this.state.school_name, 
          school_email: this.state.school_email,
          school_address_string: this.state.school_address_string,
          school_phone: this.state.school_phone
      }}),
      success: (data) => {
        this.props.handleUpdate(this.props.school, data);
      }
    })
  }

  handleCancel(event) {
    event.preventDefault();
    this.props.handleCancel();
  }

  render() {
    return (
      <form>
        <div className="form-group">
          <label>Код школи</label>
          <input name="school_code" className="form-control" type="text" value={this.state.school_code} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Назва школи</label>
          <input name="school_name" className="form-control" type="text" value={this.state.school_name} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Адреса електронної пошти</label>
          <input name="school_email" className="form-control" type="text" value={this.state.school_email} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Адреса</label>
          <input name="school_address_string" className="form-control" type="text" value={this.state.school_address_string} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Загальний телефон</label>
          <input name="school_phone" className="form-control" type="text" value={this.state.school_phone} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <div className="row">
            <div className="col-md-3">
              <button className="btn btn-success school-btn" onClick={this.handleSubmit}>Зберегти зміни</button>
            </div>
            <div className="col-md-3">
              <button className="btn btn-primary school-btn" onClick={this.handleCancel}>Відмінити</button>
            </div>  
          </div>  
        </div>
      </form>
    );
  }
}