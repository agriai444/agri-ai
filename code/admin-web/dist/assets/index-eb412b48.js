import{d as U,f as z,A as D,n as t,j as F,o as $,a9 as L,w as u,E as w,e as B,u as e,t as c,m as C,i as P,k as E,h as H,c as M,b as v,a,B as g,ak as J}from"./index-25d9365b.js";import{N as d}from"./FormItemGridItem-250b780d.js";import{N as K}from"./Form-250dd481.js";import{N as Q}from"./Grid-5a733b4e.js";import"./FormItem-608e5c8f.js";const W=U({__name:"signOut",setup(k){const p=z(),r=D(),i=t(!1),_=F();async function f(){try{i.value=!0,await r.signOut(),await p.push({name:"login"})}catch{i.value=!1,_.error(c("auth.logOutFailed"))}finally{i.value=!1}}return(m,l)=>($(),L(e(C),{type:"error",strong:"",secondary:"",round:"",loading:i.value,onClick:f},{default:u(()=>[w(B(e(c)("auth.logOut")),1)]),_:1},8,["loading"]))}}),X={class:"container_dashboard"},Y={class:"p-8 m-8 shadow-lg mx-20 border-none flex flex-col gap-2 rounded-lg"},Z={class:"post-heading mb-1"},ee={class:"gtext text-2xl font-bold underlined mb-8"},ae={class:"flex items-center space-x-4"},te=U({__name:"Profile",setup(k){var S;const{isMobile:p}=P(),r=E(()=>p?24:12),i=H(),_=F(),f=t(null),m=t(!1),l=E(()=>i.userInfo),R=t(l.value.avatar??""),h=((S=l.value.user)==null?void 0:S.email)??"",I=h.indexOf("@");t(I!==-1?h.slice(0,I):h);const T=t(l.value.description??""),b=t(l.value.fristName??""),N=t(l.value.lastName??""),A=t(l.value.avatarUrl??""),y=t(l.value.dateOfBirth??""),V=t(l.value.state??!1),x=t(l.value.gender??"Male"),j=t(l.value.userType??"Client"),O=t(l.value.country??""),q={firstName:[{required:!0,message:c("common.firstNameRequired"),trigger:["input","blur"]}]};function G(){var o;(o=f.value)==null||o.validate(s=>{if(s)_.error(c("auth.fillAllField"));else{const n={fristName:b.value,lastName:N.value,avatar:R.value,avatarUrl:A.value,dateOfBirth:y.value,description:T.value,state:V.value,gender:x.value,userType:j.value,country:O.value};m.value=!0,i.updateUserInfo(n)}})}return(o,s)=>($(),M("div",X,[v("div",Y,[v("div",Z,[v("div",ee,B(e(c)("setting.profile")),1)]),a(e(K),{ref_key:"formRef",ref:f,size:"large",model:{},rules:q,class:"space-y-4"},{default:u(()=>[a(e(Q),{span:r.value,"x-gap":24},{default:u(()=>[a(e(d),{path:"firstName",span:r.value,label:o.$t("setting.firstName")},{default:u(()=>[a(e(g),{value:b.value,"onUpdate:value":s[0]||(s[0]=n=>b.value=n),placeholder:"Enter first name"},null,8,["value"])]),_:1},8,["span","label"]),a(e(d),{path:"lastName",span:r.value,label:o.$t("setting.lastName")},{default:u(()=>[a(e(g),{value:N.value,"onUpdate:value":s[1]||(s[1]=n=>N.value=n),placeholder:"Enter last name"},null,8,["value"])]),_:1},8,["span","label"]),a(e(d),{path:"dateOfBirth",span:r.value,label:o.$t("setting.dateOfBirth")},{default:u(()=>[a(e(g),{value:y.value,"onUpdate:value":s[2]||(s[2]=n=>y.value=n),placeholder:"Enter date of birth"},null,8,["value"])]),_:1},8,["span","label"]),a(e(d),{path:"gender",span:r.value,label:o.$t("setting.gender")},{default:u(()=>[a(e(J),{value:x.value,"onUpdate:value":s[3]||(s[3]=n=>x.value=n),options:[{label:"Male",value:"Male"},{label:"Female",value:"Female"},{label:"Other",value:"Other"}],placeholder:"Select gender",clearable:""},null,8,["value"])]),_:1},8,["span","label"]),a(e(d),{path:"country",span:r.value,label:o.$t("setting.country")},{default:u(()=>[a(e(g),{value:O.value,"onUpdate:value":s[4]||(s[4]=n=>O.value=n),placeholder:"Enter country"},null,8,["value"])]),_:1},8,["span","label"])]),_:1},8,["span"]),v("div",ae,[a(e(C),{type:"primary",loading:m.value,onClick:G},{default:u(()=>[w(B(o.$t("common.save")),1)]),_:1},8,["loading"]),a(W)])]),_:1},512)])]))}}),le={class:"container_dashboard"},se={class:"bg-blue-100 rounded-lg flex items-center justify-center"},de=U({__name:"index",setup(k){return(p,r)=>($(),M("div",le,[v("div",se,[a(e(te))])]))}});export{de as default};
