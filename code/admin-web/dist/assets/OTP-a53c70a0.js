import{d as N,A as O,h as T,n as d,j as V,s as P,c as j,b as s,e as o,u as t,E as f,a as h,C as k,w as y,aa as U,t as n,o as A,B as E,m as _}from"./index-25d9365b.js";const F={class:"flex flex-col justify-center items-center gap-2 h-full"},K={class:"flex flex-col md:w-96 p-4 bg-blue-50 h-full items-center justify-center gap-4 mx-8 relative place-self-center overflow-hidden glass rounded-lg"},D={class:"text-center font-bold text-3xl gtext py-2"},R={class:"text-base text-center"},z={class:"text-primary"},L={class:"flex gap-1 justify-center items-center cursor-pointer"},H=N({__name:"OTP",setup(M){var g;const p=O(),u=((g=T().userInfo.user)==null?void 0:g.email)??"",a=d(!1),b=e=>{const r=e.indexOf("@");if(r>=0){const l=e.substring(0,r);return l.substring(0,2)+"*".repeat(l.length-2)+e.substring(r)}return e},i=d(""),w=e=>!e||/^\d+$/.test(e),c=V();function v(){}const x=P(),m=d(!0);function S(){x.start(),m.value=!1}function C(){x.finish(),m.value=!0}async function B(){try{a.value=!0,await p.verifyOTP(u,i.value),a.value=!1,S(),await U.push({name:"Chat",params:{uuid:""}}),C()}catch(e){console.error(e.message),a.value=!1,c.error(n("auth.signInFailed"))}}async function I(){try{a.value=!0,await p.reSendVerifyOTP(u),a.value=!1,c.success(" Done ")}catch(e){console.error(e.message),a.value=!1,c.error(n("auth.signInFailed"))}}return(e,r)=>(A(),j("div",F,[s("div",null,[s("div",K,[s("div",null,[s("div",D,o(t(n)("auth.emailVerification")),1),s("div",R,[f(o(t(n)("auth.sendedCode"))+" ",1),s("span",z,o(b(t(u))),1)])]),h(t(E),{class:"w-full",value:i.value,"onUpdate:value":r[0]||(r[0]=l=>i.value=l),"allow-input":w,maxlength:"6",size:"large",onInput:v,placeholder:"xxxxxx","show-button":!1,"show-count":!0,onKeyup:k(v,["enter"])},null,8,["value","onKeyup"]),h(t(_),{type:"primary",style:{width:"100%"},loading:a.value,onClick:B},{default:y(()=>[f(o(t(n)("auth.verfiy")),1)]),_:1},8,["loading"]),s("div",L,[s("span",null,o(t(n)("auth.dontRecieveCode")),1),h(t(_),{onClick:I,class:"underline text-primary"},{default:y(()=>[f(o(t(n)("auth.reSendCode")),1)]),_:1})])])])]))}});export{H as default};
