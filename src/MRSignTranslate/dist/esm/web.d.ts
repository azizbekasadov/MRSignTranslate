import { WebPlugin } from '@capacitor/core';
import type { SignMTPlugInPlugin } from './definitions';
export declare class SignMTPlugInWeb extends WebPlugin implements SignMTPlugInPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
