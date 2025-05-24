import { showToast, Toast } from "@raycast/api";
import { contents, update } from "./clipboard";

export default async () => {
  try {
    const clipboard = await contents();
    const encoded = urlEncode(clipboard);
    await update(encoded);
  } catch (e) {
    if (typeof e === "string") {
      await showToast({
        style: Toast.Style.Failure,
        title: "Encode failed",
        message: e,
      });
    }
  }
};

function urlEncode(str: string) {
  return encodeURIComponent(str).replace(/[!'()*]/g, (c) => "%" + c.charCodeAt(0).toString(16).toUpperCase());
}
