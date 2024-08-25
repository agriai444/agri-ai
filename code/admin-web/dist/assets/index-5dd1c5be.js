import{d as x,a as _,v as U,b4 as I,b3 as w,s as G,r as f,i as l,o as S,f as D,g as d,t as y,h as e,l as u,w as r,F as O,e as P,an as T,E as i,z as B,I as R}from"./index-1cb71b58.js";import{N as W}from"./Grid-21e37177.js";import{N as n}from"./FormItemGridItem-4af6fd44.js";import{a as Y}from"./FormItem-50f38bb6.js";const z=d("div",{class:"container_dashboard"},[d("div",{class:"header_dashboard"})],-1),C={class:"p-8 m-8 shadow-lg mx-20 border-none flex flex-col gap-2 rounded-lg"},V={class:"post-heading mb-1"},E={class:"gtext text-2xl font-bold underlined mb-8"},L={class:"mt-4"},X=x({__name:"index",setup(j){const{isMobile:k}=_(),o=U(()=>(k.value,24)),v=I(),b=w(),m=G(),c=f(null),g=f(!1),a=f({...v.settings}),M={defaultMessage:[{required:!0,message:l("setting.defaultMessageRequired"),trigger:["input","blur"]}],termsOfUseUrl:[{required:!0,message:l("setting.termsOfUseUrlRequired"),trigger:["input","blur"]}],privacyPolicyUrl:[{required:!0,message:l("setting.privacyPolicyUrlRequired"),trigger:["input","blur"]}],urlGooglplay:[{required:!1,message:l("setting.urlGooglplay"),trigger:["input","blur"]}],urlAppstore:[{required:!1,message:l("setting.urlAppstore"),trigger:["input","blur"]}],urlFacebook:[{required:!1,message:l("setting.urlFacebook"),trigger:["input","blur"]}],urlYoutube:[{required:!1,message:l("setting.urlYoutube"),trigger:["input","blur"]}],urlWhatsapp:[{required:!1,message:l("setting.urlWhatsapp"),trigger:["input","blur"]}],email:[{required:!1,message:l("setting.email"),trigger:["input","blur"]}],urlInstagram:[{required:!1,message:l("setting.urlInstagram"),trigger:["input","blur"]}],urlTiktok:[{required:!1,message:l("setting.urlTiktok"),trigger:["input","blur"]}],phoneNumber:[{required:!1,message:l("setting.phoneNumber"),trigger:["input","blur"]}]};async function N(){try{g.value=!0,await v.updateDataAction(a.value),g.value=!1,m.success(l("setting.updateSuccess"))}catch(p){g.value=!1,console.error(l("setting.updateFailed"),p.message),m.error(l("setting.updateFailed"))}}function A(p){var t;p.preventDefault(),(t=c.value)==null||t.validate(s=>{s?m.error(l("setting.fillAllFields")):N()})}const q=U(()=>g.value||!a.value.defaultMessage||!a.value.termsOfUseUrl||!a.value.privacyPolicyUrl),h=f([]);async function F(){try{await v.fetchDataAction(),await b.fetchDataAction({limit:1e3,offset:0}),h.value=b.listModels.filter(p=>p.isActivate).map(p=>({label:p.name,value:p.id})),a.value={...v.settings}}catch(p){console.error(l("setting.dataFetchError"),p.message)}}return S(F),(p,t)=>(P(),D(O,null,[z,d("div",C,[d("div",V,[d("div",E,y(e(l)("setting.title")),1)]),u(e(Y),{ref_key:"formRef",ref:c,model:a.value,rules:M,size:"large"},{default:r(()=>[u(e(W),{span:o.value,"x-gap":24},{default:r(()=>[u(e(n),{span:o.value,path:"defaultAiModel",label:e(l)("setting.defaultAiModel")},{default:r(()=>[u(e(T),{value:a.value.defaultAiModel.id,"onUpdate:value":t[0]||(t[0]=s=>a.value.defaultAiModel.id=s),options:h.value,placeholder:e(l)("setting.selectDefaultModel"),clearable:""},null,8,["value","options","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"defaultMessage",label:e(l)("setting.defaultMessage")},{default:r(()=>[u(e(i),{value:a.value.defaultMessage,"onUpdate:value":t[1]||(t[1]=s=>a.value.defaultMessage=s),placeholder:e(l)("setting.defaultMessage"),type:"textarea",autosize:{minRows:3,maxRows:5}},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"termsOfUseUrl",label:e(l)("setting.termsOfUseUrl")},{default:r(()=>[u(e(i),{value:a.value.termsOfUseUrl,"onUpdate:value":t[2]||(t[2]=s=>a.value.termsOfUseUrl=s),placeholder:e(l)("setting.termsOfUseUrl")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"privacyPolicyUrl",label:e(l)("setting.privacyPolicyUrl")},{default:r(()=>[u(e(i),{value:a.value.privacyPolicyUrl,"onUpdate:value":t[3]||(t[3]=s=>a.value.privacyPolicyUrl=s),placeholder:e(l)("setting.privacyPolicyUrl")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlGooglplay",label:e(l)("setting.urlGooglplay")},{default:r(()=>[u(e(i),{value:a.value.urlGooglplay,"onUpdate:value":t[4]||(t[4]=s=>a.value.urlGooglplay=s),placeholder:e(l)("setting.urlGooglplay")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlAppstore",label:e(l)("setting.urlAppstore")},{default:r(()=>[u(e(i),{value:a.value.urlAppstore,"onUpdate:value":t[5]||(t[5]=s=>a.value.urlAppstore=s),placeholder:e(l)("setting.urlAppstore")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlFacebook",label:e(l)("setting.urlFacebook")},{default:r(()=>[u(e(i),{value:a.value.urlFacebook,"onUpdate:value":t[6]||(t[6]=s=>a.value.urlFacebook=s),placeholder:e(l)("setting.urlFacebook")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlYoutube",label:e(l)("setting.urlYoutube")},{default:r(()=>[u(e(i),{value:a.value.urlYoutube,"onUpdate:value":t[7]||(t[7]=s=>a.value.urlYoutube=s),placeholder:e(l)("setting.urlYoutube")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlWhatsapp",label:e(l)("setting.urlWhatsapp")},{default:r(()=>[u(e(i),{value:a.value.urlWhatsapp,"onUpdate:value":t[8]||(t[8]=s=>a.value.urlWhatsapp=s),placeholder:e(l)("setting.urlWhatsapp")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"email",label:e(l)("setting.email")},{default:r(()=>[u(e(i),{value:a.value.email,"onUpdate:value":t[9]||(t[9]=s=>a.value.email=s),placeholder:e(l)("setting.email")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlInstagram",label:e(l)("setting.urlInstagram")},{default:r(()=>[u(e(i),{value:a.value.urlInstagram,"onUpdate:value":t[10]||(t[10]=s=>a.value.urlInstagram=s),placeholder:e(l)("setting.urlInstagram")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"urlTiktok",label:e(l)("setting.urlTiktok")},{default:r(()=>[u(e(i),{value:a.value.urlTiktok,"onUpdate:value":t[11]||(t[11]=s=>a.value.urlTiktok=s),placeholder:e(l)("setting.urlTiktok")},null,8,["value","placeholder"])]),_:1},8,["span","label"]),u(e(n),{span:o.value,path:"phoneNumber",label:e(l)("setting.phoneNumber")},{default:r(()=>[u(e(i),{value:a.value.phoneNumber,"onUpdate:value":t[12]||(t[12]=s=>a.value.phoneNumber=s),placeholder:e(l)("setting.phoneNumber")},null,8,["value","placeholder"])]),_:1},8,["span","label"])]),_:1},8,["span"]),d("div",L,[u(e(B),{type:"primary",style:{width:"100%"},size:"large",loading:g.value,disabled:q.value,onClick:A},{default:r(()=>[R(y(e(l)("setting.update")),1)]),_:1},8,["loading","disabled"])])]),_:1},8,["model"])])],64))}});export{X as default};
