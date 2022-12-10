"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.addTarget = addTarget;
exports.removeTarget = removeTarget;
exports.toggleJavaScriptEnabled = toggleJavaScriptEnabled;
loader.lazyRequireGetter(this, "_context", "devtools/client/debugger/src/utils/context");
loader.lazyRequireGetter(this, "_selectors", "devtools/client/debugger/src/selectors/index");

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at <http://mozilla.org/MPL/2.0/>. */
function addTarget(targetFront) {
  return async function (args) {
    const {
      client,
      getState,
      dispatch
    } = args;
    const cx = (0, _selectors.getContext)(getState());
    const thread = await client.addThread(targetFront);
    (0, _context.validateContext)(getState(), cx);
    dispatch({
      type: "INSERT_THREAD",
      cx,
      newThread: thread
    });
  };
}

function removeTarget(targetFront) {
  return async function (args) {
    const {
      getState,
      client,
      dispatch
    } = args;
    const cx = (0, _selectors.getContext)(getState());
    const threadActorID = targetFront.targetForm.threadActor;
    client.removeThread(threadActorID);
    dispatch({
      type: "REMOVE_THREAD",
      cx,
      threadActorID
    });
  };
}

function toggleJavaScriptEnabled(enabled) {
  return async ({
    panel,
    dispatch,
    client
  }) => {
    await client.toggleJavaScriptEnabled(enabled);
    dispatch({
      type: "TOGGLE_JAVASCRIPT_ENABLED",
      value: enabled
    });
  };
}