document.getElementById("yr").textContent = new Date().getFullYear();

document.querySelectorAll("[data-copy]").forEach(btn => {
  btn.addEventListener("click", async () => {
    try {
      await navigator.clipboard.writeText(btn.dataset.copy);
      btn.textContent = "Copied!";
      setTimeout(() => btn.textContent = "Copy", 1200);
    } catch {
      btn.textContent = "Failed";
    }
  });
});