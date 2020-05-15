##
## glsl.kak by lenormf
##

# https://www.khronos.org/registry/OpenGL/specs/gl/GLSLangSpec.4.60.html
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

# Extensions supported by the Sublime Text plugin:
# https://github.com/euler0/sublime-glsl
hook global BufCreate .+\.(vs|fs|gs|vsh|fsh|gsh|vshader|fshader|gshader|vert|frag|geom|tesc|tese|comp|glsl) %{
    set-option buffer filetype glsl
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=glsl %{
    require-module glsl
    add-highlighter window/glsl ref glsl
}

hook global WinSetOption filetype=(?!glsl).* %{
    remove-highlighter window/glsl
}

provide-module glsl %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/glsl regions
add-highlighter shared/glsl/code default-region group

add-highlighter shared/glsl/code/pragma regex ^\h*(#\h*(define|undef|if|ifdef|ifndef|else|elif|endif|error|pragma|extension|version|line)?) 1:meta
add-highlighter shared/glsl/code/ regex ^\h*#.+\b(defined|##)\b 1:meta
add-highlighter shared/glsl/code/ regex ^\h*#\h*define\h+(\S+) 1:meta
add-highlighter shared/glsl/code/macros regex \b__(LINE|FILE|VERSION)__\b 1:value

add-highlighter shared/glsl/code/keywords regex \b(break|continue|do|for|while|switch|case|default|if|else|subroutine|discard|return|layout|centroid|patch|sample)\b 1:keyword

add-highlighter shared/glsl/code/attributes regex \b(const|uniform|buffer|shared|attribute|varying|invariant|precise|coherent|volatile|restrict|readonly|writeonly|in|out|inout|flat|smooth|noperspective)\b 1:attribute

add-highlighter shared/glsl/code/types regex \b(atomic_uint|struct|int|void|bool|float|double|vec2|vec3|vec4|ivec2|ivec3|ivec4|bvec2|bvec3|bvec4|uint|uvec2|uvec3|uvec4|dvec2|dvec3|dvec4|mat2|mat3|mat4|mat2x2|mat2x3|mat2x4|mat3x2|mat3x3|mat3x4|mat4x2|mat4x3|mat4x4|dmat2|dmat3|dmat4|dmat2x2|dmat2x3|dmat2x4|dmat3x2|dmat3x3|dmat3x4|dmat4x2|dmat4x3|dmat4x4|lowp|mediump|highp|precision|sampler1D|sampler1DShadow|sampler1DArray|sampler1DArrayShadow|isampler1D|isampler1DArray|usampler1D|usampler1DArray|sampler2D|sampler2DShadow|sampler2DArray|sampler2DArrayShadow|isampler2D|isampler2DArray|usampler2D|usampler2DArray|sampler2DRect|sampler2DRectShadow|isampler2DRect|usampler2DRect|sampler2DMS|isampler2DMS|usampler2DMS|sampler2DMSArray|isampler2DMSArray|usampler2DMSArray|sampler3D|isampler3D|usampler3D|samplerCube|samplerCubeShadow|isamplerCube|usamplerCube|samplerCubeArray|samplerCubeArrayShadow|isamplerCubeArray|usamplerCubeArray|samplerBuffer|isamplerBuffer|usamplerBuffer|image1D|iimage1D|uimage1D|image1DArray|iimage1DArray|uimage1DArray|image2D|iimage2D|uimage2D|image2DArray|iimage2DArray|uimage2DArray|image2DRect|iimage2DRect|uimage2DRect|image2DMS|iimage2DMS|uimage2DMS|image2DMSArray|iimage2DMSArray|uimage2DMSArray|image3D|iimage3D|uimage3D|imageCube|iimageCube|uimageCube|imageCubeArray|iimageCubeArray|uimageCubeArray|imageBuffer|iimageBuffer|uimageBuffer|texture1D|texture1DArray|itexture1D|itexture1DArray|utexture1D|utexture1DArray|texture2D|texture2DArray|itexture2D|itexture2DArray|utexture2D|utexture2DArray|texture2DRect|itexture2DRect|utexture2DRect|texture2DMS|itexture2DMS|utexture2DMS|texture2DMSArray|itexture2DMSArray|utexture2DMSArray|texture3D|itexture3D|utexture3D|textureCube|itextureCube|utextureCube|textureCubeArray|itextureCubeArray|utextureCubeArray|textureBuffer|itextureBuffer|utextureBuffer|sampler|samplerShadow|subpassInput|isubpassInput|usubpassInput|subpassInputMS|isubpassInputMS|usubpassInputMS)\b 1:type

# XXX: the following regex doesn't highlight an exhaustive list of built-in
# variables/constants for efficiency purposes, we assume all symbols starting
# with "gl_" are built-in, since they cannot be declared in a shader anyway,
# as per the standard

add-highlighter shared/glsl/code/builtin_variables regex \b(gl_\w+)\b 1:value

add-highlighter shared/glsl/code/builtin_functions regex \b(abs|acos|acosh|all|allInvocations|allInvocationsEqual|any|anyInvocation|array|asin|asinh|atan|atanh|atomicAdd|atomicAnd|atomicCompSwap|atomicCounter|atomicCounterAdd|atomicCounterAnd|atomicCounterCompSwap|atomicCounterDecrement|atomicCounterExchange|atomicCounterIncrement|atomicCounterMax|atomicCounterMin|atomicCounterOr|atomicCounterSubtract|atomicCounterXor|atomicExchange|atomicMax|atomicMin|atomicOr|atomicXor|barrier|bitCount|bitfieldExtract|bitfieldInsert|bitfieldReverse|ceil|clamp|cos|cosh|cross|degrees|determinant|dFdx|dFdxCoarse|dFdxFine|dFdy|dFdyCoarse|dFdyFine|distance|dot|EmitStreamVertex|EmitVertex|EndPrimitive|EndStreamPrimitive|equal|exp|exp2|faceforward|findLSB|findMSB|floatBitsToInt|floatBitsToUint|floor|fma|fract|frexp|ftransform|fwidth|fwidthCoarse|fwidthFine|genFType|greaterThan|greaterThanEqual|groupMemoryBarrier|imageAtomicAdd|imageAtomicAnd|imageAtomicCompSwap|imageAtomicExchange|imageAtomicMax|imageAtomicMin|imageAtomicOr|imageAtomicXor|imageLoad|imageSamples|imageSize|imageStore|imulExtended|intBitsToFloat|interpolateAtCentroid|interpolateAtOffset|interpolateAtSample|inverse|inversesqrt|isinf|isnan|ldexp|length|lessThan|lessThanEqual|log|log2|matrixCompMult|max|memoryBarrier|memoryBarrierAtomicCounter|memoryBarrierBuffer|memoryBarrierImage|memoryBarrierShared|min|mix|mod|modf|noise1|noise2|noise3|noise4|normalize|not|notEqual|outerProduct|packDouble2x32|packHalf2x16|packSnorm2x16|packSnorm4x8|packUnorm2x16|packUnorm4x8|pow|radians|reflect|refract|round|roundEven|Sample_i0_j0|Sample_i0_j1|Sample_i1_j0|Sample_i1_j1|shadow1D|shadow1DLod|shadow1DProj|shadow1DProjLod|shadow2D|shadow2DLod|shadow2DProj|shadow2DProjLod|sign|sin|sinh|smoothstep|sqrt|step|subpassLoad|tan|tanh|texelFetch|texelFetchOffset|texture|texture1D|texture1DLod|texture1DProj|texture1DProjLod|texture2D|texture2DLod|texture2DProj|texture2DProjLod|texture3D|texture3DLod|texture3DProj|texture3DProjLod|textureCube|textureCubeLod|textureGather|textureGatherOffset|textureGatherOffsets|textureGrad|textureGradOffset|textureLod|textureLodOffset|textureOffset|textureProj|textureProjGrad|textureProjGradOffset|textureProjLod|textureProjLodOffset|textureProjOffset|textureQueryLevels|textureQueryLod|textureSamples|textureSize|transpose|trunc|uaddCarry|uintBitsToFloat|umulExtended|unpackDouble2x32|unpackHalf2x16|unpackSnorm2x16|unpackSnorm4x8|unpackUnorm2x16|unpackUnorm4x8|usubBorrow)\b 1:builtin

add-highlighter shared/glsl/code/bool_values regex \b(true|false)\b 1:value

add-highlighter shared/glsl/code/integers regex (?i)\b-?(0x[\da-f]+|\d+)u?\b 0:value
add-highlighter shared/glsl/code/floats regex (?i)\b[+-]?(\.\d+|\d+\.|\d+\.\d+)[lf]{,2}\b 0:value

add-highlighter shared/glsl/code/line_comment regex (?S)//.* 0:comment
add-highlighter shared/glsl/comment region /\* \*/ fill comment

}
