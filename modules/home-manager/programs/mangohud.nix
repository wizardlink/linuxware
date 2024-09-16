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
      gpu_core_clock = true;
      gpu_fan = true;
      gpu_junction_temp = true;
      gpu_load_change = true;
      gpu_load_color = [
        "39F900"
        "FDFD09"
        "B22222"
      ];
      gpu_load_value = [
        60
        90
      ];
      gpu_mem_clock = true;
      gpu_mem_temp = true;
      gpu_power = true;
      gpu_stats = true;
      gpu_temp = true;
      gpu_voltage = true;

      # CPU Statistics
      cpu_load_change = true;
      cpu_load_color = [
        "39F900"
        "FDFD09"
        "B22222"
      ];
      cpu_load_value = [
        60
        90
      ];
      cpu_mhz = true;
      cpu_power = true;
      cpu_stats = true;
      cpu_temp = true;

      # IO Statistics
      io_read = true;
      io_stats = true;
      io_write = true;

      # RAM Statistics
      ram = true;
      swap = true;
      vram = true;

      # FPS Statistics
      fps = true;
      fps_color_change = true;
      fps_value = [
        60
        90
      ];
      fps_color = [
        "B22222"
        "FDFD09"
        "39F900"
      ];
      frametime = true;
      frame_timing = true; # Display graphs
      histogram = true; # ^

      # Show whether gamemode is enabled for the application.
      gamemode = true;

      # Make so MangoHud starts hidden.
      no_display = true;

      # Show whether the GPU is throttling.
      throttling_status = true;

      # Show wine/proton version.
      wine = true;

      # Show the vulkan driver in-use.
      vulkan_driver = true;

      # Display the process' memory usage.
      procmem = true;

      # Show the application's architecture.
      arch = true;

      # Where to output log files.
      output_folder = /home/wizardlink/.config/MangoHud;
    };
  };
}
