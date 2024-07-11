<script lang="ts" setup>
import Hero from './Hero.vue'
import Navbar from './Navbar.vue'
import Carousel from './Carousel.vue'
import Company from './Company.vue'
import News from './News.vue'
import Features from './Features.vue'

import { Footer } from '@/components/common';
import { MainHeader } from '@/components/common';
</script>

<template>
    <!-- <div class="background">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div> -->
        <!-- <div
      style="width: 100vw; min-height: 100vh; position: fixed; z-index: -1; display: flex; justify-content: center; padding: 120px 24px 160px 24px; pointer-events: none;">
      <div
        style="background: radial-gradient(circle, rgba(2, 0, 36, 0) 0, #fafafa 100%); position: absolute; content: ''; z-index: 2; width: 100%; height: 100%; top: 0;">
      </div>
    
      <div
        style="z-index: 3; width: 100%; max-width: 640px; background-image: radial-gradient(at 27% 37%, hsla(215, 98%, 61%, 1) 0px, transparent 0%), radial-gradient(at 97% 21%, hsla(125, 98%, 72%, 1) 0px, transparent 50%), radial-gradient(at 52% 99%, hsla(354, 98%, 61%, 1) 0px, transparent 50%), radial-gradient(at 10% 29%, hsla(256, 96%, 67%, 1) 0px, transparent 50%), radial-gradient(at 97% 96%, hsla(38, 60%, 74%, 1) 0px, transparent 50%), radial-gradient(at 33% 50%, hsla(222, 67%, 73%, 1) 0px, transparent 50%), radial-gradient(at 79% 53%, hsla(343, 68%, 79%, 1) 0px, transparent 50%); position: absolute; height: 100%; filter: blur(100px) saturate(150%); top: 80px; opacity: 0.15;">
      </div>
    </div>
    <div style="background: #bb9ce6;background: -webkit-linear-gradient(151deg, #bb9ce6 0%, #ddd4e9 100%);background: linear-gradient(151deg, #bb9ce6 0%, #ddd4e9 100%);"></div> -->
  <div class="container pb-1 dark:bg-violet-950">
    <div class="sticky top-0 z-50">
     <MainHeader/>
      <!-- <Navbar /> -->
    </div>
      <main class="relative flex flex-col gap-4">
       
        <Hero/>
        <Company/>
        <Features/>
        <!-- <Carousel/> -->
    <!-- <News/> -->
      </main>



    <!-- <CustomerReview/> -->
   
    <Footer/>
  </div>

</template>
