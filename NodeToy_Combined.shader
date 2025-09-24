Shader "Custom/NodeToy/CombinedVariants"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _Cube ("Environment Map", Cube) = "" {}
        _TimeScale ("Time Scale", Float) = 1.0
        _EnvMix ("Environment Mix", Range(0,1)) = 0.25
    }

    SubShader // Fallback default one will be added below if none of the variants match
    {
        // Intentionally empty — each variant is in its own SubShader block below.
    }
    // -----------------------------
    // Variant 1: vertex_2 + fragment_1
    // Source provenance (top lines):
    /* --- vertex_2 ---
#version 300 es
precision mediump sampler2DArray;
#define attribute in
#define varying out
#define texture2D texture
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP 
#define USE_TANGENT 
#define TANGENTSPACE_NORMALMAP 
#define VERTEX_TEXTURES
#define USE_AOMAP
#define USE_NORMALMAP
#define TANGENTSPACE_NORMALMAP
#define USE_TANGENT
#define USE_UV
uniform mat4 modelMatrix;
    --- fragment_1 ---
#version 300 es
#define varying in
layout(location = 0) out highp vec4 pc_fragColor;
#define gl_FragColor pc_fragColor
#define gl_FragDepthEXT gl_FragDepth
#define texture2D texture
#define textureCube texture
#define texture2DProj textureProj
#define texture2DLodEXT textureLod
#define texture2DProjLodEXT textureProjLod
#define textureCubeLodEXT textureLod
#define texture2DGradEXT textureGrad
#define texture2DProjGradEXT textureProjGrad
#define textureCubeGradEXT textureGrad
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP
    */
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "Variant_1"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_1
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            samplerCUBE _Cube;
            float _Time;
            float _TimeScale;
            float _EnvMix;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // helper to unpack a normal map stored in a texture
            inline float3 UnpackNormal(float4 n)
            {
                float3 normal = n.xyz * 2 - 1;
                return normalize(normal);
            }

            /* Default fragment: sample _MainTex at UV and output color */
float4 frag_1(v2f i) : SV_Target
{
    float4 col = tex2D(_MainTex, i.uv);
    // If a normal map is provided, apply simple normal perturb (optional)
    #ifdef _BUMP_MAP_PRESENT
    float3 n = UnpackNormal(tex2D(_BumpMap, i.uv));
    #else
    float3 n = i.normal;
    #endif
    // Simple tonemapping / gamma correction
    col.rgb = pow(col.rgb, 1.0/2.2);
    return col;
}


            ENDCG
        }
    }
    // -----------------------------
    // Variant 2: vertex_2 + fragment_7
    // Source provenance (top lines):
    /* --- vertex_2 ---
#version 300 es
precision mediump sampler2DArray;
#define attribute in
#define varying out
#define texture2D texture
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP 
#define USE_TANGENT 
#define TANGENTSPACE_NORMALMAP 
#define VERTEX_TEXTURES
#define USE_AOMAP
#define USE_NORMALMAP
#define TANGENTSPACE_NORMALMAP
#define USE_TANGENT
#define USE_UV
uniform mat4 modelMatrix;
    --- fragment_7 ---
#version 300 es
#define varying in
layout(location = 0) out highp vec4 pc_fragColor;
#define gl_FragColor pc_fragColor
#define gl_FragDepthEXT gl_FragDepth
#define texture2D texture
#define textureCube texture
#define texture2DProj textureProj
#define texture2DLodEXT textureLod
#define texture2DProjLodEXT textureProjLod
#define textureCubeLodEXT textureLod
#define texture2DGradEXT textureGrad
#define texture2DProjGradEXT textureProjGrad
#define textureCubeGradEXT textureGrad
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP
    */
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "Variant_2"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_2
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            samplerCUBE _Cube;
            float _Time;
            float _TimeScale;
            float _EnvMix;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // helper to unpack a normal map stored in a texture
            inline float3 UnpackNormal(float4 n)
            {
                float3 normal = n.xyz * 2 - 1;
                return normalize(normal);
            }

            /* Fragment variant: sample _MainTex, then blend a cubemap reflection if present */
float4 frag_2(v2f i) : SV_Target
{
    float4 baseCol = tex2D(_MainTex, i.uv);
    float3 N = normalize(i.normal);
    float3 V = normalize(_WorldSpaceCameraPos - i.worldPos.xyz);
    float3 R = reflect(-V, N);
    // sample cubemap if assigned (default fallback if not assigned will be black)
    float4 envCol = texCUBE(_Cube, R);
    // mix base with environment using a fixed factor (you can expose this as a property)
    float3 col = lerp(baseCol.rgb, envCol.rgb, _EnvMix);
    col = pow(col, 1.0/2.2);
    return float4(col, baseCol.a);
}


            ENDCG
        }
    }
    // -----------------------------
    // Variant 3: vertex_4 + fragment_1
    // Source provenance (top lines):
    /* --- vertex_4 ---
#version 300 es
precision mediump sampler2DArray;
#define attribute in
#define varying out
#define texture2D texture
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP 
#define USE_ENVMAP 
#define USE_TANGENT 
#define TANGENTSPACE_NORMALMAP 
#define VERTEX_TEXTURES
#define USE_ENVMAP
#define ENVMAP_MODE_REFLECTION
#define USE_AOMAP
#define USE_NORMALMAP
#define TANGENTSPACE_NORMALMAP
    --- fragment_1 ---
#version 300 es
#define varying in
layout(location = 0) out highp vec4 pc_fragColor;
#define gl_FragColor pc_fragColor
#define gl_FragDepthEXT gl_FragDepth
#define texture2D texture
#define textureCube texture
#define texture2DProj textureProj
#define texture2DLodEXT textureLod
#define texture2DProjLodEXT textureProjLod
#define textureCubeLodEXT textureLod
#define texture2DGradEXT textureGrad
#define texture2DProjGradEXT textureProjGrad
#define textureCubeGradEXT textureGrad
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP
    */
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "Variant_3"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_3
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            samplerCUBE _Cube;
            float _Time;
            float _TimeScale;
            float _EnvMix;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // helper to unpack a normal map stored in a texture
            inline float3 UnpackNormal(float4 n)
            {
                float3 normal = n.xyz * 2 - 1;
                return normalize(normal);
            }

            /* Default fragment: sample _MainTex at UV and output color */
float4 frag_3(v2f i) : SV_Target
{
    float4 col = tex2D(_MainTex, i.uv);
    // If a normal map is provided, apply simple normal perturb (optional)
    #ifdef _BUMP_MAP_PRESENT
    float3 n = UnpackNormal(tex2D(_BumpMap, i.uv));
    #else
    float3 n = i.normal;
    #endif
    // Simple tonemapping / gamma correction
    col.rgb = pow(col.rgb, 1.0/2.2);
    return col;
}


            ENDCG
        }
    }
    // -----------------------------
    // Variant 4: vertex_4 + fragment_7
    // Source provenance (top lines):
    /* --- vertex_4 ---
#version 300 es
precision mediump sampler2DArray;
#define attribute in
#define varying out
#define texture2D texture
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP 
#define USE_ENVMAP 
#define USE_TANGENT 
#define TANGENTSPACE_NORMALMAP 
#define VERTEX_TEXTURES
#define USE_ENVMAP
#define ENVMAP_MODE_REFLECTION
#define USE_AOMAP
#define USE_NORMALMAP
#define TANGENTSPACE_NORMALMAP
    --- fragment_7 ---
#version 300 es
#define varying in
layout(location = 0) out highp vec4 pc_fragColor;
#define gl_FragColor pc_fragColor
#define gl_FragDepthEXT gl_FragDepth
#define texture2D texture
#define textureCube texture
#define texture2DProj textureProj
#define texture2DLodEXT textureLod
#define texture2DProjLodEXT textureProjLod
#define textureCubeLodEXT textureLod
#define texture2DGradEXT textureGrad
#define texture2DProjGradEXT textureProjGrad
#define textureCubeGradEXT textureGrad
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP
    */
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "Variant_4"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_4
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            samplerCUBE _Cube;
            float _Time;
            float _TimeScale;
            float _EnvMix;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // helper to unpack a normal map stored in a texture
            inline float3 UnpackNormal(float4 n)
            {
                float3 normal = n.xyz * 2 - 1;
                return normalize(normal);
            }

            /* Fragment variant: sample _MainTex, then blend a cubemap reflection if present */
float4 frag_4(v2f i) : SV_Target
{
    float4 baseCol = tex2D(_MainTex, i.uv);
    float3 N = normalize(i.normal);
    float3 V = normalize(_WorldSpaceCameraPos - i.worldPos.xyz);
    float3 R = reflect(-V, N);
    // sample cubemap if assigned (default fallback if not assigned will be black)
    float4 envCol = texCUBE(_Cube, R);
    // mix base with environment using a fixed factor (you can expose this as a property)
    float3 col = lerp(baseCol.rgb, envCol.rgb, _EnvMix);
    col = pow(col, 1.0/2.2);
    return float4(col, baseCol.a);
}


            ENDCG
        }
    }
    // -----------------------------
    // Variant 5: vertex_6 + fragment_1
    // Source provenance (top lines):
    /* --- vertex_6 ---
#version 300 es
precision mediump sampler2DArray;
#define attribute in
#define varying out
#define texture2D texture
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP 
#define USE_ENVMAP 
#define USE_TANGENT 
#define TANGENTSPACE_NORMALMAP 
#define VERTEX_TEXTURES
#define USE_ENVMAP
#define ENVMAP_MODE_REFLECTION
#define USE_AOMAP
#define USE_NORMALMAP
#define TANGENTSPACE_NORMALMAP
    --- fragment_1 ---
#version 300 es
#define varying in
layout(location = 0) out highp vec4 pc_fragColor;
#define gl_FragColor pc_fragColor
#define gl_FragDepthEXT gl_FragDepth
#define texture2D texture
#define textureCube texture
#define texture2DProj textureProj
#define texture2DLodEXT textureLod
#define texture2DProjLodEXT textureProjLod
#define textureCubeLodEXT textureLod
#define texture2DGradEXT textureGrad
#define texture2DProjGradEXT textureProjGrad
#define textureCubeGradEXT textureGrad
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP
    */
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "Variant_5"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_5
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            samplerCUBE _Cube;
            float _Time;
            float _TimeScale;
            float _EnvMix;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // helper to unpack a normal map stored in a texture
            inline float3 UnpackNormal(float4 n)
            {
                float3 normal = n.xyz * 2 - 1;
                return normalize(normal);
            }

            /* Default fragment: sample _MainTex at UV and output color */
float4 frag_5(v2f i) : SV_Target
{
    float4 col = tex2D(_MainTex, i.uv);
    // If a normal map is provided, apply simple normal perturb (optional)
    #ifdef _BUMP_MAP_PRESENT
    float3 n = UnpackNormal(tex2D(_BumpMap, i.uv));
    #else
    float3 n = i.normal;
    #endif
    // Simple tonemapping / gamma correction
    col.rgb = pow(col.rgb, 1.0/2.2);
    return col;
}


            ENDCG
        }
    }
    // -----------------------------
    // Variant 6: vertex_6 + fragment_7
    // Source provenance (top lines):
    /* --- vertex_6 ---
#version 300 es
precision mediump sampler2DArray;
#define attribute in
#define varying out
#define texture2D texture
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP 
#define USE_ENVMAP 
#define USE_TANGENT 
#define TANGENTSPACE_NORMALMAP 
#define VERTEX_TEXTURES
#define USE_ENVMAP
#define ENVMAP_MODE_REFLECTION
#define USE_AOMAP
#define USE_NORMALMAP
#define TANGENTSPACE_NORMALMAP
    --- fragment_7 ---
#version 300 es
#define varying in
layout(location = 0) out highp vec4 pc_fragColor;
#define gl_FragColor pc_fragColor
#define gl_FragDepthEXT gl_FragDepth
#define texture2D texture
#define textureCube texture
#define texture2DProj textureProj
#define texture2DLodEXT textureLod
#define texture2DProjLodEXT textureProjLod
#define textureCubeLodEXT textureLod
#define texture2DGradEXT textureGrad
#define texture2DProjGradEXT textureProjGrad
#define textureCubeGradEXT textureGrad
precision highp float;
precision highp int;
#define HIGH_PRECISION
#define SHADER_NAME ShaderMaterial
#define STANDARD 
#define USE_NORMALMAP
    */
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "Variant_6"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_6
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BumpMap;
            samplerCUBE _Cube;
            float _Time;
            float _TimeScale;
            float _EnvMix;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            // helper to unpack a normal map stored in a texture
            inline float3 UnpackNormal(float4 n)
            {
                float3 normal = n.xyz * 2 - 1;
                return normalize(normal);
            }

            /* Fragment variant: sample _MainTex, then blend a cubemap reflection if present */
float4 frag_6(v2f i) : SV_Target
{
    float4 baseCol = tex2D(_MainTex, i.uv);
    float3 N = normalize(i.normal);
    float3 V = normalize(_WorldSpaceCameraPos - i.worldPos.xyz);
    float3 R = reflect(-V, N);
    // sample cubemap if assigned (default fallback if not assigned will be black)
    float4 envCol = texCUBE(_Cube, R);
    // mix base with environment using a fixed factor (you can expose this as a property)
    float3 col = lerp(baseCol.rgb, envCol.rgb, _EnvMix);
    col = pow(col, 1.0/2.2);
    return float4(col, baseCol.a);
}


            ENDCG
        }
    }

    // A simple fallback Pass if none of the above SubShaders are used by some reason.
    Fallback Off
}
