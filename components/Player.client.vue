<template>
  <!-- TODO: verify rotations also work -->
  <div class="fmc-grid">
    <div id="player"></div>
    <div>
      <button v-if="!bluetoothPuzzle" @click="connect">Connect</button>
      <button v-else @click="disconnect">Disconnect</button><br />
      <button @click="reset">Reset</button><br />
      <input type="checkbox" v-model="acceptAll"><span style='color: white'>Accept All Devices</span><br />
    </div>
  </div>
</template>

<script setup lang="ts">
import { TwistyPlayer } from "cubing/twisty"
import { BluetoothPuzzle, connectSmartPuzzle, type MoveEvent } from "cubing/bluetooth"

const player = new TwistyPlayer({
  puzzle: "3x3x3",
  alg: "",
  controlPanel: "none",
  hintFacelets: "auto",
  background: "none",
});

onMounted(() => {
  setTimeout(() => {
    // @ts-ignore
    document.getElementById('player').appendChild(player);
    player.style.width = '500px';
    player.style.height = '500px';
  }, 1)
})

const handleMove = (e: MoveEvent) => {
  player.experimentalAddAlgLeaf(e.latestAlgLeaf)
}

let bluetoothPuzzle: BluetoothPuzzle | null = null;
const acceptAll = ref(false)
const connect = async () => {
  bluetoothPuzzle = await connectSmartPuzzle({
    acceptAllDevices: acceptAll.value,
  })
  bluetoothPuzzle.addAlgLeafListener(handleMove)
  console.log('connected', bluetoothPuzzle)
  // bluetoothPuzzle.addOrientationListener((e) => {
  //   console.log(e);
  // })
}

const disconnect = () => {
  if (bluetoothPuzzle) {
    console.log("disconnecting")
    bluetoothPuzzle.disconnect()
  }
}

const reset = () => {
  player.alg = ""
}
</script>

<style>
.fmc-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 1fr 1fr;
  grid-gap: 10px;
  padding: 10px;
}
</style>