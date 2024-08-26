import{K as A,L as t,bS as I,P as K,M as o,bY as E,d as se,Q as de,R as L,aw as ce,r as D,ax as ue,ay as he,v as V,V as f,a_ as M,bZ as r,W as be,b_ as U,X as a,a5 as v,b$ as fe,bP as ve,b1 as ge,aN as j}from"./index-47c41640.js";const we=A("switch",`
 height: var(--n-height);
 min-width: var(--n-width);
 vertical-align: middle;
 user-select: none;
 -webkit-user-select: none;
 display: inline-flex;
 outline: none;
 justify-content: center;
 align-items: center;
`,[t("children-placeholder",`
 height: var(--n-rail-height);
 display: flex;
 flex-direction: column;
 overflow: hidden;
 pointer-events: none;
 visibility: hidden;
 `),t("rail-placeholder",`
 display: flex;
 flex-wrap: none;
 `),t("button-placeholder",`
 width: calc(1.75 * var(--n-rail-height));
 height: var(--n-rail-height);
 `),A("base-loading",`
 position: absolute;
 top: 50%;
 left: 50%;
 transform: translateX(-50%) translateY(-50%);
 font-size: calc(var(--n-button-width) - 4px);
 color: var(--n-loading-color);
 transition: color .3s var(--n-bezier);
 `,[I({left:"50%",top:"50%",originalTransform:"translateX(-50%) translateY(-50%)"})]),t("checked, unchecked",`
 transition: color .3s var(--n-bezier);
 color: var(--n-text-color);
 box-sizing: border-box;
 position: absolute;
 white-space: nowrap;
 top: 0;
 bottom: 0;
 display: flex;
 align-items: center;
 line-height: 1;
 `),t("checked",`
 right: 0;
 padding-right: calc(1.25 * var(--n-rail-height) - var(--n-offset));
 `),t("unchecked",`
 left: 0;
 justify-content: flex-end;
 padding-left: calc(1.25 * var(--n-rail-height) - var(--n-offset));
 `),K("&:focus",[t("rail",`
 box-shadow: var(--n-box-shadow-focus);
 `)]),o("round",[t("rail","border-radius: calc(var(--n-rail-height) / 2);",[t("button","border-radius: calc(var(--n-button-height) / 2);")])]),E("disabled",[E("icon",[o("rubber-band",[o("pressed",[t("rail",[t("button","max-width: var(--n-button-width-pressed);")])]),t("rail",[K("&:active",[t("button","max-width: var(--n-button-width-pressed);")])]),o("active",[o("pressed",[t("rail",[t("button","left: calc(100% - var(--n-offset) - var(--n-button-width-pressed));")])]),t("rail",[K("&:active",[t("button","left: calc(100% - var(--n-offset) - var(--n-button-width-pressed));")])])])])])]),o("active",[t("rail",[t("button","left: calc(100% - var(--n-button-width) - var(--n-offset))")])]),t("rail",`
 overflow: hidden;
 height: var(--n-rail-height);
 min-width: var(--n-rail-width);
 border-radius: var(--n-rail-border-radius);
 cursor: pointer;
 position: relative;
 transition:
 opacity .3s var(--n-bezier),
 background .3s var(--n-bezier),
 box-shadow .3s var(--n-bezier);
 background-color: var(--n-rail-color);
 `,[t("button-icon",`
 color: var(--n-icon-color);
 transition: color .3s var(--n-bezier);
 font-size: calc(var(--n-button-height) - 4px);
 position: absolute;
 left: 0;
 right: 0;
 top: 0;
 bottom: 0;
 display: flex;
 justify-content: center;
 align-items: center;
 line-height: 1;
 `,[I()]),t("button",`
 align-items: center; 
 top: var(--n-offset);
 left: var(--n-offset);
 height: var(--n-button-height);
 width: var(--n-button-width-pressed);
 max-width: var(--n-button-width);
 border-radius: var(--n-button-border-radius);
 background-color: var(--n-button-color);
 box-shadow: var(--n-button-box-shadow);
 box-sizing: border-box;
 cursor: inherit;
 content: "";
 position: absolute;
 transition:
 background-color .3s var(--n-bezier),
 left .3s var(--n-bezier),
 opacity .3s var(--n-bezier),
 max-width .3s var(--n-bezier),
 box-shadow .3s var(--n-bezier);
 `)]),o("active",[t("rail","background-color: var(--n-rail-color-active);")]),o("loading",[t("rail",`
 cursor: wait;
 `)]),o("disabled",[t("rail",`
 cursor: not-allowed;
 opacity: .5;
 `)])]),me=Object.assign(Object.assign({},L.props),{size:{type:String,default:"medium"},value:{type:[String,Number,Boolean],default:void 0},loading:Boolean,defaultValue:{type:[String,Number,Boolean],default:!1},disabled:{type:Boolean,default:void 0},round:{type:Boolean,default:!0},"onUpdate:value":[Function,Array],onUpdateValue:[Function,Array],checkedValue:{type:[String,Number,Boolean],default:!0},uncheckedValue:{type:[String,Number,Boolean],default:!1},railStyle:Function,rubberBand:{type:Boolean,default:!0},onChange:[Function,Array]});let k;const ye=se({name:"Switch",props:me,setup(e){k===void 0&&(typeof CSS<"u"?typeof CSS.supports<"u"?k=CSS.supports("width","max(1px)"):k=!1:k=!0);const{mergedClsPrefixRef:S,inlineThemeDisabled:m}=de(e),z=L("Switch","-switch",we,fe,e,S),l=ce(e),{mergedSizeRef:$,mergedDisabledRef:h}=l,p=D(e.defaultValue),_=ue(e,"value"),b=he(_,p),y=V(()=>b.value===e.checkedValue),g=D(!1),i=D(!1),s=V(()=>{const{railStyle:n}=e;if(n)return n({focused:i.value,checked:y.value})});function d(n){const{"onUpdate:value":C,onChange:R,onUpdateValue:B}=e,{nTriggerFormInput:F,nTriggerFormChange:N}=l;C&&j(C,n),B&&j(B,n),R&&j(R,n),p.value=n,F(),N()}function O(){const{nTriggerFormFocus:n}=l;n()}function X(){const{nTriggerFormBlur:n}=l;n()}function Y(){e.loading||h.value||(b.value!==e.checkedValue?d(e.checkedValue):d(e.uncheckedValue))}function Q(){i.value=!0,O()}function Z(){i.value=!1,X(),g.value=!1}function q(n){e.loading||h.value||n.key===" "&&(b.value!==e.checkedValue?d(e.checkedValue):d(e.uncheckedValue),g.value=!1)}function G(n){e.loading||h.value||n.key===" "&&(n.preventDefault(),g.value=!0)}const H=V(()=>{const{value:n}=$,{self:{opacityDisabled:C,railColor:R,railColorActive:B,buttonBoxShadow:F,buttonColor:N,boxShadowFocus:J,loadingColor:ee,textColor:te,iconColor:ne,[f("buttonHeight",n)]:c,[f("buttonWidth",n)]:ie,[f("buttonWidthPressed",n)]:ae,[f("railHeight",n)]:u,[f("railWidth",n)]:x,[f("railBorderRadius",n)]:oe,[f("buttonBorderRadius",n)]:re},common:{cubicBezierEaseInOut:le}}=z.value;let T,P,W;return k?(T=`calc((${u} - ${c}) / 2)`,P=`max(${u}, ${c})`,W=`max(${x}, calc(${x} + ${c} - ${u}))`):(T=M((r(u)-r(c))/2),P=M(Math.max(r(u),r(c))),W=r(u)>r(c)?x:M(r(x)+r(c)-r(u))),{"--n-bezier":le,"--n-button-border-radius":re,"--n-button-box-shadow":F,"--n-button-color":N,"--n-button-width":ie,"--n-button-width-pressed":ae,"--n-button-height":c,"--n-height":P,"--n-offset":T,"--n-opacity-disabled":C,"--n-rail-border-radius":oe,"--n-rail-color":R,"--n-rail-color-active":B,"--n-rail-height":u,"--n-rail-width":x,"--n-width":W,"--n-box-shadow-focus":J,"--n-loading-color":ee,"--n-text-color":te,"--n-icon-color":ne}}),w=m?be("switch",V(()=>$.value[0]),H,e):void 0;return{handleClick:Y,handleBlur:Z,handleFocus:Q,handleKeyup:q,handleKeydown:G,mergedRailStyle:s,pressed:g,mergedClsPrefix:S,mergedValue:b,checked:y,mergedDisabled:h,cssVars:m?void 0:H,themeClass:w==null?void 0:w.themeClass,onRender:w==null?void 0:w.onRender}},render(){const{mergedClsPrefix:e,mergedDisabled:S,checked:m,mergedRailStyle:z,onRender:l,$slots:$}=this;l==null||l();const{checked:h,unchecked:p,icon:_,"checked-icon":b,"unchecked-icon":y}=$,g=!(U(_)&&U(b)&&U(y));return a("div",{role:"switch","aria-checked":m,class:[`${e}-switch`,this.themeClass,g&&`${e}-switch--icon`,m&&`${e}-switch--active`,S&&`${e}-switch--disabled`,this.round&&`${e}-switch--round`,this.loading&&`${e}-switch--loading`,this.pressed&&`${e}-switch--pressed`,this.rubberBand&&`${e}-switch--rubber-band`],tabindex:this.mergedDisabled?void 0:0,style:this.cssVars,onClick:this.handleClick,onFocus:this.handleFocus,onBlur:this.handleBlur,onKeyup:this.handleKeyup,onKeydown:this.handleKeydown},a("div",{class:`${e}-switch__rail`,"aria-hidden":"true",style:z},v(h,i=>v(p,s=>i||s?a("div",{"aria-hidden":!0,class:`${e}-switch__children-placeholder`},a("div",{class:`${e}-switch__rail-placeholder`},a("div",{class:`${e}-switch__button-placeholder`}),i),a("div",{class:`${e}-switch__rail-placeholder`},a("div",{class:`${e}-switch__button-placeholder`}),s)):null)),a("div",{class:`${e}-switch__button`},v(_,i=>v(b,s=>v(y,d=>a(ve,null,{default:()=>this.loading?a(ge,{key:"loading",clsPrefix:e,strokeWidth:20}):this.checked&&(s||i)?a("div",{class:`${e}-switch__button-icon`,key:s?"checked-icon":"icon"},s||i):!this.checked&&(d||i)?a("div",{class:`${e}-switch__button-icon`,key:d?"unchecked-icon":"icon"},d||i):null})))),v(h,i=>i&&a("div",{key:"checked",class:`${e}-switch__checked`},i)),v(p,i=>i&&a("div",{key:"unchecked",class:`${e}-switch__unchecked`},i)))))}});export{ye as N};
