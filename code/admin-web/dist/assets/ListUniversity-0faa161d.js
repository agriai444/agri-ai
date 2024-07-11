import{d as E,ap as de,y as N,aq as ae,e as se,i as M,j as T,v as t,A as l,l as e,k as a,m as f,n as ce,ar as ue,as as ve,M as I,at as me,B as g,au as pe,av as oe,r as p,t as s,E as D,N as le,aw as G,ax as _e,b as Q,ay as fe,ac as ne,a1 as S,ai as ie,az as ge,J as ye,K as he,L as be,aA as we,ae as xe,aj as $e,ak as H,g as Ce,F as ke,am as Ue,ad as X,af as Se,an as Ne,aB as Y,_ as De}from"./index-ba54923b.js";import{N as re,a as P,b as J}from"./Grid-5764c765.js";import{_ as ze}from"./AddUniversity.vue_vue_type_script_setup_true_lang-5079cd01.js";import{a as Re}from"./FormItem-2280ab67.js";import{N as Ae}from"./Result-dd39de02.js";const Me={class:"flex gap-4 item-center"},Oe={class:"flex flex-col"},Be={class:"font-bold text-base"},Fe={class:"w-36"},Te={class:"flex gap-3 item-end"},Ie={class:"text-xs"},Le={class:""},je={class:"text-yellow-400 font-bold"},qe={class:"ml-4"},Ve={class:"flex gap-2 items-center"},Ee=a("div",null,"Created At:",-1),Ke={class:"ml-4"},Ge={class:"ml-4"},Pe={class:"flex gap-2 items-center"},Je=a("div",null,"Updated At:",-1),We={class:"ml-4"},He="research",Qe=E({__name:"CardUnversity",props:{row:{}},setup(R){de();const $=R,o=N(()=>$.row),w=`${ae}/${He}/${o.value.image_url}`,y=o.value.is_active?"success":"error",{isMobile:d}=se();return(v,u)=>(M(),T("div",Me,[t(e(ve),{dot:"",processing:!1,type:e(y)},{default:l(()=>[t(e(ue),{round:"",size:"medium",src:w})]),_:1},8,["type"]),a("div",Oe,[a("div",Be,[t(e(me),{"line-clamp":1},{tooltip:l(()=>[a("div",Fe,f(o.value.name),1)]),default:l(()=>[I(f(o.value.name)+" ",1)]),_:1})]),a("div",Te,[a("div",Ie,f(new Date(o.value.created_at).toLocaleString()),1),t(e(pe),{style:{maxWidth:"300px"},class:ce(e(d)?"ml-36":""),trigger:"hover",placement:"bottom"},{trigger:l(()=>[t(e(g),{icon:"ep:info-filled"})]),default:l(()=>[a("div",Le,[a("div",null,[t(e(g),{icon:"ep:info-filled",class:"inline-flex"}),I(" information about "),a("span",je,f(o.value.name),1)]),a("div",qe,[a("div",Ve,[t(e(g),{icon:"lets-icons:date-today-duotone",class:"inline-flex"}),Ee]),a("div",Ke,f(new Date(o.value.created_at).toLocaleString()),1)]),a("div",Ge,[a("div",Pe,[t(e(g),{icon:"lets-icons:date-today-duotone",class:"inline-flex"}),Je]),a("div",We,f(new Date(o.value.updated_at).toLocaleString()),1)])])]),_:1},8,["class"])])])]))}}),Xe={class:"flex flex-col gap-2 p-4"},Ye={class:"flex gap-2 items-center"},Ze=a("div",{class:"font-bold"},"Filter",-1),et={class:"ml-4"},tt={class:"flex flex-col gap-2 p-2"},at={class:"flex gap-2 items-center"},st=a("div",{class:"font-bold"},"Sort",-1),ot={class:"ml-4"},lt={class:"flex justify-around"},nt=a("div",null,"Sort By Date",-1),it={class:"flex gap-2 justify-between"},rt={class:"flex gap-2 items-center"},dt=a("div",null,"Clear Filters",-1),ct={class:"flex gap-2 items-center"},ut=a("div",null,"Clear Sorter",-1),vt=E({__name:"OptionFilter",props:{mainColumn:{},columns:{}},setup(R){const o=oe.getData().map(c=>({label:c.name,value:c.code,disabled:!1})),w=p(null),y=R,d=N(()=>y.mainColumn),v=N(()=>y.columns),u=p("ascend"),h=p("ascend"),r=()=>{u.value=u.value==="ascend"?"descend":"ascend",q(u.value)},z=()=>{h.value=u.value==="ascend"?"descend":"ascend",m(h.value)},O=N(()=>u.value==="ascend"?s("Sort By Name"):s("Sort By Name")),L=N(()=>u.value==="ascend"?"bi:sort-up":"bi:sort-down"),j=N(()=>h.value==="ascend"?"bi:sort-up":"bi:sort-down");function A(){d.value.filterOptionValue=null}p(v);function q(c){d.value.sorter={compare:(b,C)=>b.name.length-C.name.length,multiple:2},d.value.sortOrder=c}function m(c){d.value.sorter={compare:(b,C)=>{const k=new Date(b.updated_at),B=new Date(C.updated_at);return k<B?c==="ascend"?-1:1:k>B?c==="ascend"?1:-1:0},multiple:3},d.value.sortOrder=c}function _(){d.value.sortOrder=!1}const x=(c,b)=>~b.country.indexOf(c);function V(c,b){d.value.filterOptionValue=c,d.value.filter=x}function W(c){citiesRef.value=c,message.info(JSON.stringify(c))}return(c,b)=>(M(),T("div",Xe,[a("div",null,[a("div",Ye,[t(e(g),{icon:"solar:filter-bold-duotone"}),Ze]),a("div",et,[a("div",tt,[t(e(le),{filterable:"",multiple:"",trigger:"hover","onUpdate:value":V,options:e(o),"consistent-menu-width":!1,"max-tag-count":2},{default:l(()=>[t(e(D),null,{default:l(()=>[I(f(e(s)("university.country")),1)]),_:1})]),_:1},8,["options"]),t(e(_e),{value:w.value,"onUpdate:value":[b[0]||(b[0]=C=>w.value=C),W]},{default:l(()=>[t(e(re),{"y-gap":8,cols:2},{default:l(()=>[t(e(P),null,{default:l(()=>[t(e(G),{value:"Beijing",label:"Beijing"})]),_:1}),t(e(P),null,{default:l(()=>[t(e(G),{value:"Shanghai",label:"Shanghai"})]),_:1}),t(e(P),null,{default:l(()=>[t(e(G),{value:"Guangzhou",label:"Guangzhou"})]),_:1}),t(e(P),null,{default:l(()=>[t(e(G),{value:"Shenzen",label:"Shenzhen"})]),_:1})]),_:1})]),_:1},8,["value"])])])]),a("div",null,[a("div",at,[t(e(g),{icon:"ic:twotone-sort",class:"text-base"}),st]),a("div",ot,[a("div",lt,[a("div",{onClick:r,class:"flex gap-2 items-center cursor-pointer"},[t(e(g),{icon:L.value,class:"text-base"},null,8,["icon"]),a("div",null,f(O.value),1)]),a("div",{onClick:z,class:"flex gap-2 items-center cursor-pointer"},[t(e(g),{icon:j.value,class:"text-base"},null,8,["icon"]),nt])])])]),a("div",it,[t(e(D),{strong:"",secondary:"",type:"error",onClick:A},{default:l(()=>[a("div",rt,[t(e(g),{icon:"flat-color-icons:clear-filters",class:"text-base"}),dt])]),_:1}),t(e(D),{strong:"",secondary:"",type:"error",onClick:_},{default:l(()=>[a("div",ct,[t(e(g),{icon:"carbon:sort-remove",class:"text-base"}),ut])]),_:1})])]))}}),mt={class:"flex justify-end p-2"},pt={class:"flex rounded-full p-2 justify-center items-start bg-blue-200"},_t=E({__name:"FilterTable",props:{mainColumn:{},columns:{}},setup(R){const $=R,o=N(()=>$.mainColumn),w=N(()=>$.columns),y=Q(),d=[{key:"header",type:"render",render:()=>S(vt,{mainColumn:o.value,columns:w.value})}];function v(u){y.info(String(u))}return(u,h)=>(M(),T("div",mt,[t(e(ne),null,{default:l(()=>[t(e(fe),{trigger:"click",options:d,onSelect:v},{default:l(()=>[a("div",pt,[t(e(g),{icon:"solar:filter-bold-duotone",class:"text-xl"})])]),_:1})]),_:1})]))}}),ft={class:"border-none shadow-none flex flex-col gap-2 p-2 rounded-lg"},gt={class:"post-heading mb-1"},yt={class:"gtext text-2xl font-bold underlined"},ht={style:{display:"flex","justify-content":"flex-end"}},Z="University",ee="research",bt=E({__name:"UpdateUnversity",props:{row:{}},setup(R){const $=ie(),o=R,w=Q(),d=oe.getData().map(m=>({label:m.name,value:m.code,disabled:!1})),v=p(null),u=p(!1),h=p({id:o.row.id,name:o.row.name,country_code:o.row.country_code,is_active:o.row.is_active,user_id:o.row.user_id,type_added:o.row.type_added,image_url:o.row.image_url,created_at:o.row.created_at,updated_at:o.row.updated_at}),r=p({id:o.row.id,name:o.row.name,country_code:o.row.country_code,is_active:o.row.is_active,user_id:o.row.user_id,type_added:o.row.type_added,image_url:o.row.image_url,created_at:o.row.created_at,updated_at:o.row.updated_at}),z={name:[{required:!0,message:s("university.nameRequired"),trigger:["input","blur"]}],country:[{required:!0,message:s("university.countryRequired")}],image:[{required:!0,message:s("university.imageRequired"),trigger:["input","blur"]}]};async function O(){try{u.value=!0,await $.updateUniversityAction({id:o.row.id,updates:r.value}),u.value=!1,$.showModelUpdate=!1,w.success(s("commn.updateSuccess"))}catch(m){console.error(s("common.updateFailed"),m.message),w.error(s("common.updateFailed"))}}const L=async({file:m,data:_,headers:x,withCredentials:V,action:W,onFinish:c,onError:b,onProgress:C})=>{try{const k={loaded:20,total:100},B=Math.round(k.loaded*100/k.total);C({percent:B});const{data:K,error:F}=await xe.storage.from(ee).upload(`${Z}/${m.name}`,m.file,{cacheControl:"3600",upsert:!1});if(C({percent:Math.ceil(10)}),F)if(F.statusCode==="409"&&F.error==="Duplicate")r.value.image_url=`${Z}/${m.name}`,console.log("Resource already exists. Skipping upload."),c();else throw F;K&&(r.value.image_url=K.path,c())}catch(k){console.log(k),w.error(k.message),b()}},j=p([{id:"pp",name:r.value.image_url||"",status:"finished",url:`${ae}/${ee}/${r.value.image_url}`}]);function A(){return!r.value.name||!r.value.country_code||!r.value.image_url||r.value.name===h.value.name&&r.value.country_code===h.value.country_code&&r.value.is_active===h.value.is_active&&r.value.image_url===h.value.image_url}const q=m=>S("div",{style:{display:"flex",alignItems:"center"}},[S(g,{icon:"flagpack:"+(typeof m.value=="string"?m.value.toLowerCase():m.value),class:"w-6 h-6"}),S("span",{style:{marginLeft:"8px"}},m.label)]);return(m,_)=>(M(),T("div",ft,[a("div",gt,[a("div",yt,f(e(s)("university.editUniversity")),1)]),t(e(Re),{ref_key:"formRef",ref:v,model:r.value,rules:z,size:"large"},{default:l(()=>[a("div",null,[t(e(re),{cols:4,span:24,"x-gap":24},{default:l(()=>[t(e(J),{span:12,path:"image",label:e(s)("university.image")},{default:l(()=>[t(e(ge),{accept:"image/*","list-type":"image-card",min:1,max:1,path:"image","default-file-list":j.value,"custom-request":L},null,8,["default-file-list"])]),_:1},8,["label"]),t(e(J),{span:12,path:"name",label:e(s)("university.universityName")},{default:l(()=>[t(e(ye),{value:r.value.name,"onUpdate:value":_[0]||(_[0]=x=>r.value.name=x),placeholder:"University Name",clearable:"",onKeydown:_[1]||(_[1]=he(be(()=>{},["prevent"]),["enter"]))},null,8,["value"])]),_:1},8,["label"]),t(e(J),{span:12,path:"country",label:e(s)("university.country")},{default:l(()=>[t(e(le),{filterable:"",trigger:"hover",value:r.value.country_code,"onUpdate:value":_[2]||(_[2]=x=>r.value.country_code=x),options:e(d),"render-label":q},{default:l(()=>[t(e(D),null,{default:l(()=>[I(f(e(s)("university.country")),1)]),_:1})]),_:1},8,["value","options"])]),_:1},8,["label"]),t(e(J),{span:12,path:"state",label:e(s)("university.state")},{default:l(()=>[t(e(we),{value:r.value.is_active,"onUpdate:value":_[3]||(_[3]=x=>r.value.is_active=x),size:"large"},null,8,["value"])]),_:1},8,["label"])]),_:1})]),a("div",ht,[t(e(D),{type:"primary",style:{width:"100%"},size:"large",loading:u.value,disabled:A(),onClick:O},{default:l(()=>[I(f(e(s)("university.editUniversity")),1)]),_:1},8,["loading","disabled"])])]),_:1},8,["model"])]))}}),wt={class:"container_dashboard"},xt={class:"header_dashboard"},$t={class:"flex gap-2 justify-end items-center"},Ct={class:"flex gap-2 items-center"},kt={class:"hidden md:block"},Ut={class:"flex gap-2 items-center"},St={class:"hidden md:block"},Nt={class:"cursor-pointer"},Dt={class:""},zt={key:0,class:"border-red-400 bg-red-100 p-4 rounded-lg"},te=3,Rt=E({__name:"ListUniversity",setup(R){const{iconRender:$}=Ue(),o=p(!1),w=p(!1),y=p(!0),d=p(!1),v=ie(),u=p([]),{isMobile:h}=se(),r=$e(),z=Q(),O=p(null),L=N(()=>v.listUniversity),j=N(()=>v.countTotalData),A=H({page:j,pageSize:te,showSizePicker:!0,onChange:n=>{A.page=n},onUpdatePageSize:n=>{A.pageSize=n,A.page=1}});function q(n){const i=r.warning({title:s("chat.deleteConfirmation"),content:s("chat.deleteConfirmationMessage"),positiveText:s("common.yes"),negativeText:s("common.no"),onPositiveClick:async()=>{try{i.loading=!0,await v.deleteUniversityAction(n.id),z.success(s("chat.deleteSuccess"))}catch{i.loading=!1,z.error(s("chat.deleteFailed"))}finally{i.loading=!1}}})}async function m(n){v.showModelUpdate=!0,O.value=n}const _=H({title:s("university.university"),key:"university",render(n){return S(Qe,{row:n})}}),x=H([{type:"selection",options:["all","none"],disabled(n){return n.type_added==="default"}},_,{title:s("research.actions"),key:"actions",align:"center",width:100,render(n){return S("div",{class:"flex gap-1"},[S(D,{strong:!0,tertiary:!0,size:"small",loading:w.value,style:"border-radius:100%",onClick:async()=>{try{await m(n)}catch(i){console.error(s("common.updateFailed"),i.message)}}},{default:()=>S($({icon:"fluent:edit-32-regular",color:"blue"}))}),S(D,{strong:!0,tertiary:!0,size:"small",loading:o.value,onClick:()=>q(n)},{default:()=>S($({icon:"fluent:delete-32-regular",color:"red"}))})])}}]);async function V(){try{await v.fetchUniversitiesAction({limit:te,offset:1}),y.value=!0,y.value=!1,d.value=!1}catch(n){z.error(s("common.errorSomeThing")+" "+n.message),console.error(s("common.errorSomeThing"),n.message),console.error(d.value),d.value=!0,console.error(d.value),y.value=!1}}Ce(async()=>{V()});const c=p(null);function b(n,i){_.filterOptionValue=n[i.key]}const C=p(x);function k(n){C.value.forEach(i=>{if(i.sortOrder!==void 0){if(!n){i.sortOrder=!1;return}i.key===n.columnKey?i.sortOrder=n.order:i.sortOrder=!1}})}const B=n=>n.id;function K(n){u.value=n}function F(){const n=r.warning({title:s("chat.deleteConfirmation"),content:s("chat.deleteConfirmationMessage"),positiveText:s("common.yes"),negativeText:s("common.no"),onPositiveClick:async()=>{try{n.loading=!0;const i=u.value.map(U=>v.deleteUniversityAction(U));await Promise.all(i),z.success(s("chat.deleteSuccess"))}catch(i){console.error(s("common.deleteFailed"),i.message),z.error(s("common.deleteFailed"))}finally{n.loading=!1}}})}return(n,i)=>(M(),T(ke,null,[a("div",wt,[a("div",xt,f(e(s)("university.universitys")),1),a("div",$t,[t(e(D),{onClick:i[0]||(i[0]=U=>e(v).showModelAdd=!0),type:"primary"},{default:l(()=>[a("div",Ct,[t(e(g),{icon:"mdi:add-bold",class:"text-base"}),a("div",kt,f(e(s)("university.addUniversity")),1)])]),_:1}),t(e(D),{strong:"",secondary:"",type:"error",disabled:!(u.value.length>0),onClick:F},{default:l(()=>[a("div",Ut,[t(e(g),{icon:"fluent:delete-32-regular",class:"text-base"}),a("div",St,f(e(s)("common.delete")),1)])]),_:1},8,["disabled"]),a("div",Nt,[t(e(_t),{mainColumn:_,columns:x},null,8,["mainColumn","columns"])])]),a("div",Dt,[t(e(ne),{vertical:"",size:12},{default:l(()=>[d.value?(M(),T("div",zt,[t(e(Ae),{status:"error",title:"Error",description:"It's red"},{footer:l(()=>[t(e(D),{size:"small",loading:y.value,onClick:i[1]||(i[1]=U=>V())},{default:l(()=>[I(" try Again ")]),_:1},8,["loading"])]),_:1})])):X("",!0),d.value?X("",!0):(M(),Se(e(Ne),{key:1,remote:"",size:(e(h),"small"),striped:"",loading:y.value,ref_key:"dataTableInst",ref:c,columns:x,data:L.value,pagination:A,"max-height":e(h)?400:370,"min-height":e(h)?380:370,"paginate-single-page":!1,"checked-row-keys":u.value,"onUpdate:checkedRowKeys":[i[2]||(i[2]=U=>u.value=U),K],"onUpdate:filters":b,"onUpdate:sorter":k,"row-key":B},null,8,["size","loading","columns","data","pagination","max-height","min-height","checked-row-keys"]))]),_:1})])]),a("div",null,[t(e(Y),{show:e(v).showModelAdd,"onUpdate:show":i[3]||(i[3]=U=>e(v).showModelAdd=U),"mask-closable":!1,"auto-focus":!1,preset:"card",style:{width:"95%","max-width":"640px"}},{default:l(()=>[t(ze)]),_:1},8,["show"]),t(e(Y),{show:e(v).showModelUpdate,"onUpdate:show":i[4]||(i[4]=U=>e(v).showModelUpdate=U),"mask-closable":!1,"auto-focus":!1,preset:"card",style:{width:"95%","max-width":"640px"}},{default:l(()=>[t(bt,{row:O.value},null,8,["row"])]),_:1},8,["show"])])],64))}});const Tt=De(Rt,[["__scopeId","data-v-cce6c7ce"]]);export{Tt as default};
