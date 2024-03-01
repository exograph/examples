import type { CodegenConfig } from '@graphql-codegen/cli';
import { addTypenameSelectionDocumentTransform } from '@graphql-codegen/client-preset';

const config: CodegenConfig = {
  schema: 'http://localhost:9876/graphql',
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
        persistedDocuments: {
          hashAlgorithm: 'sha256'
        },
      },
      documentTransforms: [addTypenameSelectionDocumentTransform],
      plugins: [],
    },
  },
};
export default config;
