self: super: {
  ungoogled-chromium = super.ungoogled-chromium.override {
    channel = "stable";
    enableWideVine = true;
  };
}
