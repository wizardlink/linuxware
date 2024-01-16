{ ... }:

{
  programs.mangohud = {
    enable = true;

    settings = {
      # Limitations
      fps_limit = 165;
      vsync = 1;
      gl_vsync = 0;

      # GPU Statistics
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_load_change = true;
      gpu_load_value = [ 60 90 ];
      gpu_load_color = [ "39F900" "FDFD09" "B22222" ];

      # CPU Statistics
      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_mhz = true;
      cpu_load_change = true;
      cpu_load_value = [ 60 90 ];
      cpu_load_color = [ "39F900" "FDFD09" "B22222" ];


      # IO Statistics
      io_stats = true;
      io_read = true;
      io_write = true;


      # RAM Statistics
      vram = true;
      ram = true;
      swap = true;

      # FPS Statistics
      fps = true;
      fps_color_change = true;
      fps_value = [ 60 90 ];
      fps_color = [ "B22222" "FDFD09" "39F900" ];
      frametime = true;
      frame_timing = true; # Display graphs
      histogram = true; # ^

      # Show whether gamemode is enabled for the application.
      gamemode = true;

      # Make so MangoHud starts hidden.
      no_display = true;

      # Where to output log files.
      output_folder = /home/wizardlink/.config/MangoHud;
    };
  };
}
