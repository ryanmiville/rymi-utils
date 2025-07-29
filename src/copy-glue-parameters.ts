import { Clipboard, getSelectedText, showHUD, showToast, Toast } from "@raycast/api";

export default async () => {
  try {
    const text = await getSelectedText();
    const json = convertToGlueParametersJson(text);
    await Clipboard.copy(json);
    await showHUD("Copied to clipboard");
  } catch (e) {
    if (typeof e === "string") {
      await showToast({
        style: Toast.Style.Failure,
        title: "Glue Parameters conversion failed",
        message: e,
      });
    }
  }
};

function convertToGlueParametersJson(input: string): string {
  const lines = input
    .trim()
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0);

  if (lines.length === 0) {
    throw "No parameters found in clipboard";
  }

  if (lines.length % 2 !== 0) {
    throw "Invalid format: parameters must be in key-value pairs";
  }

  const params: Record<string, string> = {};

  for (let i = 0; i < lines.length; i += 2) {
    const key = lines[i];
    const value = lines[i + 1];
    params[key] = value;
  }

  return JSON.stringify(params, null, 2);
}
