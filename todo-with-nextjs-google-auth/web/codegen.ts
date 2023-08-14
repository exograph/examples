import type { CodegenConfig } from '@graphql-codegen/cli';

const config: CodegenConfig = {
  schema: 'http://0.0.0.0:9876/graphql',
  documents: [
    'src/app/**/*.{ts,tsx}',
    'src/components/**/*.{ts,tsx}'
  ],
  generates: {
    './src/__generated__/': {
      preset: 'client',
      presetConfig: {
        extension: '.generated.tsx',
        baseTypesPath: 'types.ts',
        fragmentMasking: { unmaskFunctionName: 'getFragmentData' },
      },
      plugins: [],
    },
  },
};
export default config;
