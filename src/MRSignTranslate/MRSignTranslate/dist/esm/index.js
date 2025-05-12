import { registerPlugin } from '@capacitor/core';
const SignMTPlugIn = registerPlugin('SignMTPlugIn', {
    web: () => import('./web').then((m) => new m.SignMTPlugInWeb()),
});
export * from './definitions';
export { SignMTPlugIn };
//# sourceMappingURL=index.js.map