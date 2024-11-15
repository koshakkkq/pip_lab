namespace WebNotes.Models.User;

public class BaseResponse<T>
{
    public T User { get; set; }
    public Message Error { get; set; }
}