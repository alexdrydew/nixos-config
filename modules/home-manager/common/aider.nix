{
  lib,
  pkgs,
  config,
  ...
}: let
  yaml = pkgs.formats.yaml {};
  json = pkgs.formats.json {};
  gemini-2-5-pro-meta = {
    "max_tokens" = 8192;
    "max_input_tokens" = 1048576;
    "max_output_tokens" = 64000;
    "max_images_per_prompt" = 3000;
    "max_videos_per_prompt" = 10;
    "max_video_length" = 1;
    "max_audio_length_hours" = 8.4;
    "max_audio_per_prompt" = 1;
    "max_pdf_size_mb" = 30;
    "input_cost_per_image" = 0;
    "input_cost_per_video_per_second" = 0;
    "input_cost_per_audio_per_second" = 0;
    "input_cost_per_token" = 0;
    "input_cost_per_character" = 0;
    "input_cost_per_token_above_128k_tokens" = 0;
    "input_cost_per_character_above_128k_tokens" = 0;
    "input_cost_per_image_above_128k_tokens" = 0;
    "input_cost_per_video_per_second_above_128k_tokens" = 0;
    "input_cost_per_audio_per_second_above_128k_tokens" = 0;
    "output_cost_per_token" = 0;
    "output_cost_per_character" = 0;
    "output_cost_per_token_above_128k_tokens" = 0;
    "output_cost_per_character_above_128k_tokens" = 0;
    "litellm_provider" = "vertex_ai-language-models";
    "mode" = "chat";
    "supports_system_messages" = true;
    "supports_function_calling" = true;
    "supports_vision" = true;
    "supports_audio_input" = true;
    "supports_video_input" = true;
    "supports_pdf_input" = true;
    "supports_response_schema" = true;
    "supports_tool_choice" = true;
    "source" = "https://cloud.google.com/vertex-ai/generative-ai/pricing";
  };
in {
  options.aider = {
    enable = lib.mkEnableOption "Enable aider" // {default = true;};
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {
        "read" = [
          "${config.home.homeDirectory}/CONVENTIONS.md"
          "${config.home.homeDirectory}/EDIT_GEMINI_CONVENTIONS.md"
        ];
        "dark-mode" = true;
        "model-settings-file" = "${config.home.homeDirectory}/.aider.model.settings.yml";
        "auto-commits" = true;
        "auto-lint" = false;
        "check-update" = true;
        "vim" = true;
        "editor" = "nvim";
        "no-attribute-author" = true;
        "no-attribute-committer" = true;
      };
      description = "Aider configuration attributes";
    };
    modelSettings = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [
        {
          name = "fireworks_ai/accounts/fireworks/models/deepseek-v3";
          edit_format = "diff";
          weak_model_name = null;
          use_repo_map = true;
          send_undo_reply = false;
          lazy = false;
          reminder = "sys";
          examples_as_sys_msg = true;
          extra_params = {max_tokens = 16384;};
          cache_control = false;
          caches_by_default = true;
          use_system_prompt = true;
          use_temperature = true;
          streaming = true;
        }
        {
          name = "fireworks_ai/accounts/fireworks/models/deepseek-r1";
          edit_format = "diff";
          weak_model_name = null;
          use_repo_map = true;
          send_undo_reply = false;
          lazy = false;
          reminder = "sys";
          examples_as_sys_msg = true;
          extra_params = {max_tokens = 16384;};
          cache_control = false;
          caches_by_default = true;
          use_system_prompt = true;
          use_temperature = true;
          streaming = true;
        }
        {
          name = "openai/deepseek-r1";
          edit_format = "diff";
          weak_model_name = null;
          use_repo_map = true;
          send_undo_reply = false;
          lazy = false;
          reminder = "sys";
          examples_as_sys_msg = true;
          extra_params = {max_tokens = 16384;};
          cache_control = false;
          caches_by_default = true;
          use_system_prompt = true;
          use_temperature = true;
          streaming = true;
          editor_model_name = "openai/claude-sonnet-3-5";
          editor_edit_format = "editor-diff";
        }
        {
          name = "openai/claude-sonnet-4";
          overeager = true;
          edit_format = "diff";
          weak_model_name = "openai/gemini-2.0-flash";
          use_repo_map = true;
          examples_as_sys_msg = true;
          extra_params = {
            # extra_headers = {
            #   anthropic-beta = "prompt-caching-2024-07-31,pdfs-2024-09-25,output-128k-2025-02-19";
            # };
            max_tokens = 64000;
          };
          cache_control = true;
          editor_model_name = "openai/claude-3-7-sonnet-20250219";
          editor_edit_format = "editor-diff";
          accepts_settings = ["thinking_tokens"];
        }
        {
          name = "openai/claude-3-7-sonnet-20250219";
          edit_format = "diff";
          use_repo_map = true;
          examples_as_sys_msg = true;
          extra_params = {
            max_tokens = 64000;
            thinking = {
              type = "enabled";
              budget_tokens = 32000;
            };
          };
          editor_model_name = "openai/claude-3-7-sonnet-20250219";
          editor_edit_format = "editor-diff";
        }
        {
          name = "openai/claude-sonnet-3-5";
          edit_format = "diff";
          use_repo_map = true;
          examples_as_sys_msg = true;
          extra_params = {
            max_tokens = 64000;
          };
          editor_edit_format = "editor-diff";
        }
        {
          name = "openai/gemini-2-5-pro";
          edit_format = "diff-fenced";
          use_repo_map = true;
          weak_model_name = "openai/gemini-2.0-flash";
          extra_params = {
            thinking = {
              type = "enabled";
              budget_tokens = 32000; # Adjust this number
            };
          };
        }
        {
          name = "openai/gemini-2-5-pro-vertex-openrouter";
          edit_format = "diff-fenced";
          use_repo_map = true;
          extra_params = {
            thinking = {
              type = "enabled";
              budget_tokens = 32000; # Adjust this number
            };
          };
        }
        {
          name = "openai/gemini-2.0-flash";
          edit_format = "diff";
          use_repo_map = true;
        }
        {
          name = "openai/gpt-5-2025-08-07";
          edit_format = "diff";
          weak_model_name = "openai/gpt-5-nano";
          use_repo_map = true;
          use_temperature = false;
          extra_params = {
            reasoning_effort = "high";
          };
        }
        {
          name = "openai/gpt-5-nano";
          edit_format = "diff";
          weak_model_name = "openai/gpt-5-nano";
          use_repo_map = true;
          use_temperature = false;
          extra_params = {
            reasoning_effort = "medium";
          };
        }
        {
          name = "openrouter/qwen/qwen3-235b-a22b";
          edit_format = "diff";
          system_prompt_prefix = "/no_think";
          use_temperature = 0.7;
          extra_params = {
            max_tokens = 24000;
            top_p = 0.8;
            top_k = 20;
            min_p = 0.0;
            temperature = 0.7;
            extra_body = {
              provider = {
                order = ["Together"];
              };
            };
          };
        }
      ];
      description = "Aider model configuration";
    };
  };

  config = lib.mkIf config.aider.enable {
    home = {
      # use pipx instead
      # packages = [pkgs.aider-chat];

      file = {
        ".aider.conf.yml".source = yaml.generate "aider-conf" config.aider.settings;
        ".aider.model.settings.yml".source = yaml.generate "aider-model-settings" config.aider.modelSettings;
        ".aider.model.metadata.json".source = json.generate "aider-model-meta" {
          "fireworks_ai/accounts/fireworks/models/deepseek-r1" = {
            "max_tokens" = 8192;
            "max_input_tokens" = 65336;
            "max_output_tokens" = 8192;
            "input_cost_per_token" = 0.000003;
            "output_cost_per_token" = 0.00000219;
            "litellm_provider" = "fireworks_ai";
            "mode" = "chat";
            "supports_function_calling" = false;
            "supports_assistant_prefill" = false;
            "supports_tool_choice" = false;
            "supports_prompt_caching" = false;
          };
          "openai/deepseek-r1" = {
            "max_tokens" = 8192;
            "max_input_tokens" = 65336;
            "max_output_tokens" = 8192;
            "input_cost_per_token" = 0.000003;
            "output_cost_per_token" = 0.00000219;
            "litellm_provider" = "openai";
            "mode" = "chat";
            "supports_function_calling" = false;
            "supports_assistant_prefill" = false;
            "supports_tool_choice" = false;
            "supports_prompt_caching" = false;
          };
          "openai/claude-3-7-sonnet-20250219" = {
            "max_tokens" = 8192;
            "max_input_tokens" = 200000;
            "max_output_tokens" = 8192;
            "input_cost_per_token" = 0.000003;
            "output_cost_per_token" = 0.000015;
            "input_cost_per_image" = 0.0048;
            "mode" = "chat";
            "supports_function_calling" = true;
            "supports_vision" = true;
            "tool_use_system_prompt_tokens" = 159;
            "supports_assistant_prefill" = true;
            "supports_tool_choice" = true;
          };
          "openai/claude-sonnet-4" = {
            "max_tokens" = 8192;
            "max_input_tokens" = 200000;
            "max_output_tokens" = 8192;
            "input_cost_per_token" = 0.000003;
            "output_cost_per_token" = 0.000015;
            "input_cost_per_image" = 0.0048;
            "mode" = "chat";
            "supports_function_calling" = true;
            "supports_vision" = true;
            "tool_use_system_prompt_tokens" = 159;
            "supports_assistant_prefill" = true;
            "supports_tool_choice" = true;
          };
          "openai/claude-sonnet-3-5" = {
            "max_tokens" = 8192;
            "max_input_tokens" = 200000;
            "max_output_tokens" = 8192;
            "input_cost_per_token" = 0.000003;
            "output_cost_per_token" = 0.000015;
            "input_cost_per_image" = 0.0048;
            "mode" = "chat";
            "supports_function_calling" = true;
            "supports_vision" = true;
            "tool_use_system_prompt_tokens" = 159;
            "supports_assistant_prefill" = true;
            "supports_tool_choice" = true;
          };
          "openai/o3-mini" = {
            "max_tokens" = 100000;
            "max_input_tokens" = 200000;
            "max_output_tokens" = 100000;
            "input_cost_per_token" = 0.0000011;
            "output_cost_per_token" = 0.0000044;
            "cache_read_input_token_cost" = 0.00000055;
            "mode" = "chat";
            "supports_function_calling" = true;
            "supports_parallel_function_calling" = false;
            "supports_vision" = false;
            "supports_prompt_caching" = true;
            "supports_response_schema" = true;
            "supports_tool_choice" = true;
          };
          "openai/gemini-2-5-pro" = gemini-2-5-pro-meta;
          "openai/gemini-2-5-pro-vertex-openrouter" = gemini-2-5-pro-meta;
          "openai/gemini-2.0-flash" = {
            "max_tokens" = 8192;
            "max_input_tokens" = 1048576;
            "max_output_tokens" = 8192;
            "max_images_per_prompt" = 3000;
            "max_videos_per_prompt" = 10;
            "max_video_length" = 1;
            "max_audio_length_hours" = 8.4;
            "max_audio_per_prompt" = 1;
            "max_pdf_size_mb" = 30;
            "litellm_provider" = "openrouter";
            "mode" = "chat";
            "supports_system_messages" = true;
            "supports_function_calling" = true;
            "supports_vision" = true;
            "supports_response_schema" = true;
            "supports_audio_output" = true;
            "supports_tool_choice" = true;
          };
          "openrouter/qwen/qwen3-235b-a22b" = {
            "max_tokens" = 262144;
            "max_input_tokens" = 262144;
            "max_output_tokens" = 8192;
            "input_cost_per_token" = 0.0000012;
            "output_cost_per_token" = 0.0000059;
            "supports_function_calling" = true;
            "supports_parallel_function_calling" = true;
            "supports_system_messages" = true;
            "supports_tool_choice" = true;
          };
          "openai/gpt-5-2025-08-07" = {
            "max_tokens" = 128000;
            "max_input_tokens" = 400000;
            "max_output_tokens" = 128000;
            "input_cost_per_token" = 0.00000125;
            "output_cost_per_token" = 0.00001;
            "cache_read_input_token_cost" = 0.000000125;
            "litellm_provider" = "openai";
            "mode" = "chat";
            "supported_endpoints" = [
              "/v1/chat/completions"
              "/v1/batch"
              "/v1/responses"
            ];
            "supported_modalities" = [
              "text"
              "image"
            ];
            "supported_output_modalities" = [
              "text"
            ];
            "supports_pdf_input" = true;
            "supports_function_calling" = true;
            "supports_parallel_function_calling" = true;
            "supports_response_schema" = true;
            "supports_vision" = true;
            "supports_prompt_caching" = true;
            "supports_system_messages" = true;
            "supports_tool_choice" = true;
            "supports_native_streaming" = true;
            "supports_reasoning" = true;
          };
          "openai/gpt-5-nano" = {
            "max_tokens" = 128000;
            "max_input_tokens" = 400000;
            "max_output_tokens" = 128000;
            "input_cost_per_token" = 0.00000005;
            "output_cost_per_token" = 0.0000004;
            "cache_read_input_token_cost" = 0.000000005;
            "litellm_provider" = "openai";
            "mode" = "chat";
            "supported_endpoints" = [
              "/v1/chat/completions"
              "/v1/batch"
              "/v1/responses"
            ];
            "supported_modalities" = [
              "text"
              "image"
            ];
            "supported_output_modalities" = [
              "text"
            ];
            "supports_pdf_input" = true;
            "supports_function_calling" = true;
            "supports_parallel_function_calling" = true;
            "supports_response_schema" = true;
            "supports_vision" = true;
            "supports_prompt_caching" = true;
            "supports_system_messages" = true;
            "supports_tool_choice" = true;
            "supports_native_streaming" = true;
            "supports_reasoning" = true;
          };
        };
      };
    };
  };
}
