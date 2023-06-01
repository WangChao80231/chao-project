package com.mp.common;//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//


public class JsonForResult<T> {
    private boolean success;
    private String message;
    private T data;
    private int total;

    public static <T> JsonForResultBuilder<T> builder() {
        return new JsonForResultBuilder();
    }

    public boolean isSuccess() {
        return this.success;
    }

    public String getMessage() {
        return this.message;
    }

    public T getData() {
        return this.data;
    }

    public int getTotal() {
        return this.total;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setData(T data) {
        this.data = data;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof JsonForResult)) {
            return false;
        } else {
            JsonForResult<?> other = (JsonForResult)o;
            if (!other.canEqual(this)) {
                return false;
            } else if (this.isSuccess() != other.isSuccess()) {
                return false;
            } else {
                label41: {
                    Object this$message = this.getMessage();
                    Object other$message = other.getMessage();
                    if (this$message == null) {
                        if (other$message == null) {
                            break label41;
                        }
                    } else if (this$message.equals(other$message)) {
                        break label41;
                    }

                    return false;
                }

                Object this$data = this.getData();
                Object other$data = other.getData();
                if (this$data == null) {
                    if (other$data != null) {
                        return false;
                    }
                } else if (!this$data.equals(other$data)) {
                    return false;
                }

                if (this.getTotal() != other.getTotal()) {
                    return false;
                } else {
                    return true;
                }
            }
        }
    }

    protected boolean canEqual(Object other) {
        return other instanceof JsonForResult;
    }

    public int hashCode() {
//        int PRIME = true;
        int result = 1;
        result = result * 59 + (this.isSuccess() ? 79 : 97);
        Object $message = this.getMessage();
        result = result * 59 + ($message == null ? 43 : $message.hashCode());
        Object $data = this.getData();
        result = result * 59 + ($data == null ? 43 : $data.hashCode());
        result = result * 59 + this.getTotal();
        return result;
    }

    public String toString() {
        return "JsonForResult(success=" + this.isSuccess() + ", message=" + this.getMessage() + ", data=" + this.getData() + ", total=" + this.getTotal() + ")";
    }

    public JsonForResult() {
    }

    public JsonForResult(boolean success, String message, T data, int total) {
        this.success = success;
        this.message = message;
        this.data = data;
        this.total = total;
    }

    public static class JsonForResultBuilder<T> {
        private boolean success;
        private String message;
        private T data;
        private int total;

        JsonForResultBuilder() {
        }

        public JsonForResultBuilder<T> success(boolean success) {
            this.success = success;
            return this;
        }

        public JsonForResultBuilder<T> message(String message) {
            this.message = message;
            return this;
        }

        public JsonForResultBuilder<T> data(T data) {
            this.data = data;
            return this;
        }

        public JsonForResultBuilder<T> total(int total) {
            this.total = total;
            return this;
        }

        public JsonForResult<T> build() {
            return new JsonForResult(this.success, this.message, this.data, this.total);
        }

        public String toString() {
            return "JsonForResult.JsonForResultBuilder(success=" + this.success + ", message=" + this.message + ", data=" + this.data + ", total=" + this.total + ")";
        }
    }
}
