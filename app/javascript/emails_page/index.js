import React from "react"
import { main as EmailPage } from "./components/page"

document.addEventListener("DOMContentLoaded", () => {
  EmailPage.initialize()
})

document.addEventListener("turbolinks:before-render", () => {
  EmailPage.uninitialize()
})

document.addEventListener("turbolinks:render", () => {
  EmailPage.initialize()
})
