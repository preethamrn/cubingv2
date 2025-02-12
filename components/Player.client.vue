<template>
  <!-- TODO: integrate bluetooth connection-->
  <!-- TODO: bluetooth move will transform the cube display -->
  <!-- TODO: verify rotations also work -->
  <div id="player"></div>
</template>

<script setup>
import { TwistyPlayer } from "cubing/twisty"

const player = new TwistyPlayer({
  puzzle: "3x3x3",
  alg: "R U R'",
  controlPanel: "none",
  hintFacelets: "auto",
  background: "none",
});

onMounted(() => {
  setTimeout(() => {
    document.getElementById('player').appendChild(player);
    player.style.width = '500px';
    player.style.height = '500px';
  }, 1)
})
</script>

<style></style>