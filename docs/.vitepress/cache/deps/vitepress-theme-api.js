import {
  createBaseVNode,
  createElementBlock,
  defineComponent,
  normalizeStyle,
  openBlock,
  renderSlot
} from "./chunk-FA4MWVOB.js";

// node_modules/vitepress-theme-api/dist/vitepress-theme-api.es.js
var p = { class: "container-content" };
var a = { class: "left" };
var _ = defineComponent({
  __name: "DividePage",
  props: {
    top: {}
  },
  setup(n) {
    const e = n;
    return (t, d) => (openBlock(), createElementBlock("div", p, [
      createBaseVNode("div", a, [
        renderSlot(t.$slots, "left")
      ]),
      createBaseVNode("div", {
        class: "right",
        style: normalizeStyle({ top: e.top ? `${e.top}px` : "0px" })
      }, [
        renderSlot(t.$slots, "right")
      ], 4)
    ]));
  }
});
export {
  _ as DividePage
};
//# sourceMappingURL=vitepress-theme-api.js.map
