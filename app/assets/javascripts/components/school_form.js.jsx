class SchoolForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      school_code: '',
      school_name: '',
      school_email: '',
      school_address_string: '',
      school_phone: ''
    };   

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this); 
  };

  handleChange(event) {
    event.preventDefault();
  }

  handleSubmit(event) {
    event.preventDefault();
  }

  render() {
    return (
      <form>
        <h3>SCHOOL EDITING FORM</h3>
        <div className="form-group">
          <label>Код школи</label>
          <input name="school_code" className="form-control" type="text" value={this.props.school.school_code} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Назва школи</label>
          <input name="school_name" className="form-control" type="text" value={this.props.school.school_name} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Адреса електронної пошти</label>
          <input name="school_email" className="form-control" type="text" value={this.props.school.school_email} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Адреса</label>
          <input name="school_address_string" className="form-control" type="text" value={this.props.school.school_address_string} onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <label>Загальний телефон</label>
          <input name="school_phone" className="form-control" type="text" value={this.props.school.school_phone} onChange={this.handleChange} />
        </div>
        <button className="btn btn-success" onClick={this.handleSubmit}>Зберегти зміни</button>
      </form>
    );
  }
}