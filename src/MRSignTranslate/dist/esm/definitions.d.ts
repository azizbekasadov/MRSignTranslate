export interface SignMTPlugInPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
