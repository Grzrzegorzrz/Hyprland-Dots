// ==UserScript==
// @name           Tab Navigation and Reordering Hotkeys
// @namespace      tab_navigation_hotkeys
// @version        1.1
// @description    Use control-j and control-k to navigate tabs
// ==/UserScript

// clear cache in about:support to refresh. This goes for all files

function key_move_tabs() {
  for (let {mod, key, id, delta} of [
    {mod: "ctrl",  key: "J", id: "key_move_next", delta: +1},
    {mod: "ctrl",  key: "K", id: "key_move_prev", delta: -1},
  ]) {
    UC_API.Hotkeys.define({
      modifiers: mod,
      key,
      id,
      command: win => {
        win.gBrowser.tabContainer.advanceSelectedTab(delta, true);
      },
    }).autoAttach({ suppressOriginalKey: true });
  }
}

key_move_tabs();
