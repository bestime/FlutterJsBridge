import { uglify } from 'rollup-plugin-uglify'
import babel from '@rollup/plugin-babel';
import typescript from "typescript"
import rollupTypescript from "rollup-plugin-typescript2"

function zeroTo2 (data) {
  if(data < 10) {
    return '0' + data
  } else {
    return String(data)
  }
}

function simpleFromatTime (date) {
  var year = zeroTo2(date.getFullYear());
  var month = zeroTo2(date.getMonth() + 1);
  var day = zeroTo2(date.getDate());
  var hour = zeroTo2(date.getHours());
  var minute = zeroTo2(date.getMinutes());
  var second = zeroTo2(date.getSeconds());

  return `${year}-${month}-${day} ${hour}:${minute}:${second}`
}


function getBanner (type) {
  return `/**  
 * 供flutter使用的 jsBridge
 * @QQ 1174295440
 * @author Bestime
 * @update ${simpleFromatTime(new Date())}
 */`
}

export default {
  input: './src/main.ts',
  
  output: [
    {
      file:  'dist/release/index.min.js',
      banner: getBanner('iife'),
      format: 'iife',    
      strict: true,
      name: 'FlutterJsBridge',
      indent: false,
      sourcemap: false,
      interop: false,
    }
  ],
  plugins: [
    rollupTypescript({
      include: "src/**/*.ts",
      exclude: "node_modules/**",
      typescript: typescript,
      useTsconfigDeclarationDir: true,
      allowNonTsExtensions: false,
    }),

    babel({
      babelHelpers: 'bundled',
      exclude: "node_modules/**",
      extensions: [
        '.ts',
        '.js'
      ]
    }),

    uglify({
      ie8: true,
      warnings: false,
      compress: true,
      output: {
        beautify: false,
        comments: function(node, comment) {
            return /@see/i.test(comment.value);
        }
      }
    }),    
  ]
};