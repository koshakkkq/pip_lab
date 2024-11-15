namespace WebNotes.Models.Notes {
    using Message=NuGet.Protocol.Plugins.Message;

    public class VMNotes {
        public IQueryable<Note> notes { get; set; }
        public string? message { get; set; }
    }
}
