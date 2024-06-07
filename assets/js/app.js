// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// document.addEventListener('DOMContentLoaded', function() {
//   const transactionsContainer = document.getElementById('transactions-container');
//   const addTransactionButton = document.getElementById('add-transaction');

//   addTransactionButton.addEventListener('click', function() {
//     const newTransactionIndex = transactionsContainer.children.length;
//     const newTransactionTemplate = `
//       <div class="transaction-fields" data-index="${newTransactionIndex}">
//         <input type="hidden" name="ledger_entry[transactions_sort][]" value="${newTransactionIndex}" />
//         <label>Date</label>
//         <input type="datetime-local" name="ledger_entry[transactions][${newTransactionIndex}][date]" />
//         <label>Transaction Type</label>
//         <select name="ledger_entry[transactions][${newTransactionIndex}][transaction_type]">
//           <option value="debit">debit</option>
//           <option value="credit">credit</option>
//         </select>
//         <label>Account</label>
//         <select name="ledger_entry[transactions][${newTransactionIndex}][account_id]">
//           <!-- Populate options dynamically if needed -->
//         </select>
//         <label>Currency</label>
//         <select name="ledger_entry[transactions][${newTransactionIndex}][currency_id]">
//           <!-- Populate options dynamically if needed -->
//         </select>
//         <label>Amount</label>
//         <input type="text" name="ledger_entry[transactions][${newTransactionIndex}][amount]" />
//         <button type="button" class="remove-transaction">
//           <span class="icon">X</span>
//         </button>
//       </div>
//     `;
//     transactionsContainer.insertAdjacentHTML('beforeend', newTransactionTemplate);
//   });

//   transactionsContainer.addEventListener('click', function(e) {
//     if (e.target.closest('.remove-transaction')) {
//       e.preventDefault();
//       e.target.closest('.transaction-fields').remove();
//     }
//   });
// });
