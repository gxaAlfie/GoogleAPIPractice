import React, { Component } from "react"
import ReactDOM from "react-dom"
import MailThread from "./mail_thread"

class Page extends Component {
  constructor(props) {
    super(props)
    const initialState = $.extend(this.props, {}, {
      mailThreads: []
    })
  }

  componentDidMount(){
    this.fetchAccountThreads()
  }

  componentWillUnmount(){
    if(this.ajaxRequest && this.ajaxRequest.abort) {
      this.ajaxRequest.abort()
    }
  }

  fetchAccountThreads(){
    this.ajaxRequest = $.ajax({
      url: `/accounts/${this.props.account.id}/fetch_threads`,
      method: "GET",
      dataType: "json",
      success: (data) => {
        this.setState({mailThreads: data.threads})
      }
    })
  }

  renderThreads(){
    if(this.state && this.state.mailThreads){
      let threads = this.state.mailThreads.map((thread, index) => {
        return(
          <MailThread key={`thread-${index}`} thread={thread}/>
        )
      })

      return(
        <div>
          <table className="table">
          </table>
          {threads}
        </div>
      )
    }
  }

  render(){
    return(
      <div>
        {this.renderThreads()}
      </div>
    )
  }
}

const main = {
  initialize() {
    let listElement = document.querySelector(".threads-list")
    if(listElement) {
      ReactDOM.render(
        <Page account={JSON.parse(listElement.dataset["account"])}/>, listElement
      )
    }
  },

  uninitialize() {
    let listElement = document.querySelector(".threads-list")
    if(listElement) {
      ReactDOM.unmountComponentAtNode(listElement)
    }
  }
}

export{main}
